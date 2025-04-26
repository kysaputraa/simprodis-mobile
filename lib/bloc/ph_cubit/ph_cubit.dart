import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'ph_state.dart';

class PhCubit extends Cubit<PhState> {
  PhCubit() : super(PhInitial());

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required phAirBaku,
    required phAirClarif,
    required phAirProduksi,
    required phReservoir1,
    required phReservoir2,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(PhLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addPH');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          'ph_air_baku': phAirBaku,
          'ph_air_clarif': phAirClarif,
          'ph_air_produksi': phAirProduksi,
          'ph_reservoir1': phReservoir1,
          'ph_reservoir2': phReservoir2,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(PhSuccessInsert(message: jsonResponse['message'].toString()));
      } else {
        emit(PhError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(PhError(message: e.toString()));
    }
  }
}
