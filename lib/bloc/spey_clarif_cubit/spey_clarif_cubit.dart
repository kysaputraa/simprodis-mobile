import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/spey_clarif_model.dart';
part 'spey_clarif_state.dart';

class SpeyClarifCubit extends Cubit<SpeyClarifState> {
  SpeyClarifCubit() : super(SpeyClarifInitial());

  void fetchData({required idInstalasi}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(SpeyClarifLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getSpeyClarifByInstalasi');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": idInstalasi},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      SpeyClarifModel data = SpeyClarifModel.fromJson(jsonResponse);
      DataClarif? dataClarif = data.data;
      int jumlah = 0;
      if (dataClarif != null && dataClarif.jumlahClarif != null) {
        jumlah = int.parse(dataClarif.jumlahClarif!);
      }
      List<int> clarifList = List<int>.generate(jumlah, (index) => index + 1);

      if (data.code == 1) {
        emit(SpeyClarifSuccess(data: clarifList, message: data.message));
      } else {
        emit(SpeyClarifError(message: data.message.toString()));
      }
    } catch (e) {
      emit(SpeyClarifError(message: e.toString()));
    }
  }

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required spey_clarif,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(SpeyClarifLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addSpeyClarif');
      String speyClarifString = spey_clarif.join(',');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          "spey_clarif": speyClarifString,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        // fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
        emit(
          SpeyClarifSuccessInsert(message: jsonResponse['message'].toString()),
        );
      } else {
        // String messageString;
        // if (jsonResponse['message'] is List) {
        //   messageString = jsonResponse['message'].join(', ');
        // } else if (jsonResponse['message'] != null) {
        //   messageString = jsonResponse['message'].toString();
        // } else {
        //   messageString = '';
        // }
        emit(SpeyClarifError(message: jsonResponse['message'].toString()));
        fetchData(idInstalasi: id_instalasi);
      }
    } catch (e) {
      emit(SpeyClarifError(message: e.toString()));
    }
  }

  void selectItems(List<String> item) {
    if (state is SpeyClarifSuccess) {
      final currentState = state as SpeyClarifSuccess;
      emit(SpeyClarifSuccess(data: currentState.data, selectedItems: item));
    }
  }
}
