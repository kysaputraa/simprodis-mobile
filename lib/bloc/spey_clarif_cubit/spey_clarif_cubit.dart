import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'spey_clarif_state.dart';

class SpeyClarifCubit extends Cubit<SpeyClarifState> {
  SpeyClarifCubit() : super(SpeyClarifInitial());

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required penetral,
    required koagulan,
    required desinfektan,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(SpeyClarifLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addSpeyClarif');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          "isi_penjernih": penetral,
          "isi_koagulan": koagulan,
          "isi_desinfektan": desinfektan,
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
        // fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
      }
    } catch (e) {
      emit(SpeyClarifError(message: e.toString()));
    }
  }
}
