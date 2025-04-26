import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/kwh_model.dart';
import 'package:http/http.dart' as http;

part 'kwh_state.dart';

class KwhCubit extends Cubit<KwhState> {
  KwhCubit() : super(KwhInitial());

  void fetchData({required id_instalasi, required tanggal}) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(KwhLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getKWHByInstalasiDate');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": id_instalasi, "tanggal": tanggal},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      KwhModel data = KwhModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(KwhSuccess(data: data.data ?? [], message: data.message));
      } else {
        emit(KwhError(message: data.message.toString()));
      }
    } catch (e) {
      emit(KwhError(message: e.toString()));
    }
  }

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required lwbp,
    required wbp,
    required kvarh,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(KwhLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addKWH');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "tanggal": tanggal,
          "jam_lapor": jam,
          "lwbp": lwbp,
          "wbp": wbp,
          "kvarh": kvarh,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
      } else {
        emit(KwhError(message: jsonResponse['message'].toString()));
        fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
      }
    } catch (e) {
      emit(KwhError(message: e.toString()));
    }
  }
}
