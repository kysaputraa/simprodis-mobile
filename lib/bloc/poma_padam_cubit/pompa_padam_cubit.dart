import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simprodis_flutter/model/pompa_padam_model.dart';

part 'pompa_padam_state.dart';

class PompaPadamCubit extends Cubit<PompaPadamState> {
  PompaPadamCubit() : super(PompaPadamInitial());

  void fetchData({required idPompa}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(PompaPadamLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getPompaPadamNotHidupByPompa');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_pompa": idPompa},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      PompaPadamModel data = PompaPadamModel.fromJson(jsonResponse);
      DataPompaPadam? dataPompaPadam = data.data;
      if (data.code == 1) {
        emit(PompaPadamSuccess(data: dataPompaPadam));
      } else {
        emit(PompaPadamError(message: data.message.toString()));
      }
    } catch (e) {
      emit(PompaPadamError(message: e.toString()));
    }
  }

  void simpan({required id_pompa, required waktuPadam}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(PompaPadamLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addPompaPadam');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_pompa": id_pompa,
          "id_petugas_hp": idPetugasHP,
          "waktu_padam": waktuPadam,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(
          PompaPadamSuccessInsert(message: jsonResponse['message'].toString()),
        );
        fetchData(idPompa: id_pompa);
      } else {
        emit(PompaPadamError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(PompaPadamError(message: e.toString()));
    }
  }

  void updateWaktuHidup({
    required idPompa,
    required id_padam,
    required waktu_hidup_kembali,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(PompaPadamLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}updatePompaPadamById');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id": id_padam,
          "waktu_hidup_kembali": waktu_hidup_kembali,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        // fetchData(id_pompa: id_pompa, tanggal: tanggal);
        emit(
          PompaPadamSuccessInsert(message: jsonResponse['message'].toString()),
        );
        fetchData(idPompa: idPompa);
      } else {
        emit(PompaPadamError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(PompaPadamError(message: e.toString()));
    }
  }

  void selectWaktuPadam(String item) {
    if (state is PompaPadamSuccess) {
      final currentState = state as PompaPadamSuccess;
      emit(
        PompaPadamSuccess(
          data: currentState.data,
          selectedWaktuHidup: currentState.selectedWaktuHidup,
          selectedWaktuPadam: item,
        ),
      );
    }
  }

  void selectWaktuHidup(String item) {
    if (state is PompaPadamSuccess) {
      final currentState = state as PompaPadamSuccess;
      emit(
        PompaPadamSuccess(
          data: currentState.data,
          selectedWaktuPadam: currentState.selectedWaktuPadam,
          selectedWaktuHidup: item,
        ),
      );
    }
  }
}
