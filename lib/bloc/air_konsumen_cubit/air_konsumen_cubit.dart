import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

part 'air_konsumen_state.dart';

class AirKonsumenCubit extends Cubit<AirKonsumenState> {
  AirKonsumenCubit() : super(AirKonsumenInitial());

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required nopam,
    required ph,
    required kekeruhan,
    required sisaChlor,
    required namaPelanggan,
    required alamatPelanggan,
    required latPelanggan,
    required longPelanggan,
    required zona,
    required kdCabang,
    required kdKelurahan,
    required kdKecamatan,
    required gol,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(AirKonsumenLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addUjiAirKonsumen');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          'nopam': nopam,
          'zona': zona,
          'gol': gol,
          'kdcabang': kdCabang,
          'kd_kelurahan': kdKelurahan,
          'kd_kecamatan': kdKecamatan,
          'alamat': alamatPelanggan,
          'nama_pelanggan': namaPelanggan,
          'lat_pelanggan': latPelanggan,
          'long_pelanggan': longPelanggan,
          'ph_air_konsumen': ph,
          'kekeruhan_air_konsumen': kekeruhan,
          'sisa_chlor_air_konsumen': sisaChlor,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(
          AirKonsumenSuccessInsert(message: jsonResponse['message'].toString()),
        );
      } else {
        emit(AirKonsumenError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(AirKonsumenError(message: e.toString()));
    }
  }
}
