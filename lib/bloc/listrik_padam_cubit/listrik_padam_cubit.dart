import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/listrik_padam_model.dart';
part 'listrik_padam_state.dart';

class ListrikPadamCubit extends Cubit<ListrikPadamState> {
  ListrikPadamCubit() : super(ListrikPadamInitial());

  void fetchData({required idInstalasi}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(ListrikPadamLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getPadamNotHidupByInstalasi');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": idInstalasi},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      ListrikPadamModel data = ListrikPadamModel.fromJson(jsonResponse);
      DataListrikPadam? dataListrikPadam = data.data;
      if (data.code == 1) {
        emit(ListrikPadamSuccess(data: dataListrikPadam));
      } else {
        emit(ListrikPadamError(message: data.message.toString()));
      }
    } catch (e) {
      emit(ListrikPadamError(message: e.toString()));
    }
  }

  void simpan({required id_instalasi, required waktuPadam}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(ListrikPadamLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addPadam');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "waktu_padam": waktuPadam,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(
          ListrikPadamSuccessInsert(
            message: jsonResponse['message'].toString(),
          ),
        );
        fetchData(idInstalasi: id_instalasi);
      } else {
        emit(ListrikPadamError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(ListrikPadamError(message: e.toString()));
    }
  }

  void updateWaktuHidup({
    required idInstalasi,
    required id_padam,
    required waktu_hidup_kembali,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(ListrikPadamLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}updatePadamById');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_padam": id_padam,
          "waktu_hidup_kembali": waktu_hidup_kembali,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        // fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
        emit(
          ListrikPadamSuccessInsert(
            message: jsonResponse['message'].toString(),
          ),
        );
        fetchData(idInstalasi: idInstalasi);
      } else {
        emit(ListrikPadamError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(ListrikPadamError(message: e.toString()));
    }
  }

  void selectWaktuPadam(String item) {
    if (state is ListrikPadamSuccess) {
      final currentState = state as ListrikPadamSuccess;
      emit(
        ListrikPadamSuccess(
          data: currentState.data,
          selectedWaktuHidup: currentState.selectedWaktuHidup,
          selectedWaktuPadam: item,
        ),
      );
    }
  }

  void selectWaktuHidup(String item) {
    if (state is ListrikPadamSuccess) {
      final currentState = state as ListrikPadamSuccess;
      emit(
        ListrikPadamSuccess(
          data: currentState.data,
          selectedWaktuPadam: currentState.selectedWaktuPadam,
          selectedWaktuHidup: item,
        ),
      );
    }
  }
}
