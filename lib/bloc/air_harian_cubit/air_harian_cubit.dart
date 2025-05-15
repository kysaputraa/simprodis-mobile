import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'air_harian_state.dart';

class AirHarianCubit extends Cubit<AirHarianState> {
  AirHarianCubit() : super(AirHarianInitial());

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required phAirBaku,
    required kekeruhanAirBaku,
    required phAirProduksi,
    required kekeruhanAirProduksi,
    required sisaChlorProduksi,
    required dosisAlumProduksi,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(AirHarianLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addUjiAirHarian');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          'ph_air_baku': phAirBaku,
          'kekeruhan_air_baku': kekeruhanAirBaku,
          'ph_air_produksi': phAirProduksi,
          'kekeruhan_air_produksi': kekeruhanAirProduksi,
          'sisa_chlor_produksi': sisaChlorProduksi,
          'dosis_alum': dosisAlumProduksi,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(
          AirHarianSuccessInsert(message: jsonResponse['message'].toString()),
        );
      } else {
        emit(AirHarianError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(AirHarianError(message: e.toString()));
    }
  }
}
