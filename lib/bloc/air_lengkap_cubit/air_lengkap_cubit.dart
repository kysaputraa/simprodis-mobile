import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'air_lengkap_state.dart';

class AirLengkapCubit extends Cubit<AirLengkapState> {
  AirLengkapCubit() : super(AirLengkapInitial());

  void simpan({
    required id_instalasi,
    required tanggal,
    required id_titik,
    required jam,
    required coliform,
    required suhu,
    required zatTerlarut,
    required kekeruhan,
    required warna,
    required bau,
    required ph,
    required nitrat,
    required nitrit,
    required kromium,
    required besi,
    required mangan,
    required sisaChlor,
    required fluorida,
    required aluminium,
    required timbal,
    required cadmium,
    required arsen,
    required sulfat,
    required seng,
    required tembaga,
    required sianida,
    required chlorida,
    required amonia,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(AirLengkapLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addUjiAirLengkap');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_titik": id_titik,
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          "coliform": coliform,
          "suhu": suhu,
          "zat_terlarut": zatTerlarut,
          "kekeruhan": kekeruhan,
          "warna": warna,
          "bau": bau,
          "ph": ph,
          "nitrat": nitrat,
          "nitrit": nitrit,
          "kromium": kromium,
          "besi": besi,
          "mangan": mangan,
          "sisa_chlor": sisaChlor,
          "fluorida": fluorida,
          "aluminium": aluminium,
          "timbal": timbal,
          "cadmium": cadmium,
          "arsen": arsen,
          "sulfat": sulfat,
          "seng": seng,
          "tembaga": tembaga,
          "sianida": sianida,
          "chlorida": chlorida,
          "amonia": amonia,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(
          AirLengkapSuccessInsert(message: jsonResponse['message'].toString()),
        );
      } else {
        emit(AirLengkapError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(AirLengkapError(message: e.toString()));
    }
  }
}
