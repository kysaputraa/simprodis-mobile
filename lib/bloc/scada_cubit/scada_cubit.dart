import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'scada_state.dart';

class ScadaCubit extends Cubit<ScadaState> {
  ScadaCubit() : super(ScadaInitial());

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required variable,
    required waktu_lapor,
    required jam_lapor,
    required ph_intake,
    required kekeruhan_intake,
    required kons_alumn_campuran,
    required frek_pompa_alumn,
    required scm,
    required frek_pompa_chlor,
    required frek_pompa_kapur,
    required kekeruhan_sedimentasi,
    required spey_sedimen,
    required cuci_filter,
    required tinggi_reservoir,
    required ph_resservoir,
    required sisa_chlor,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(ScadaLoading());
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
          "waktu_lapor": waktu_lapor,
          "jam_lapor": jam_lapor,
          "ph_intake": ph_intake,
          "kekeruhan_intake": kekeruhan_intake,
          "kons_alumn_campuran": kons_alumn_campuran,
          "frek_pompa_alumn": frek_pompa_alumn,
          "scm": scm,
          "frek_pompa_chlor": frek_pompa_chlor,
          "frek_pompa_kapur": frek_pompa_kapur,
          "kekeruhan_sedimentasi": kekeruhan_sedimentasi,
          "spey_sedimen": spey_sedimen,
          "cuci_filter": cuci_filter,
          "tinggi_reservoir": tinggi_reservoir,
          "ph_resservoir": ph_resservoir,
          "sisa_chlor": sisa_chlor,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(ScadaSuccessInsert(message: jsonResponse['message'].toString()));
      } else {
        emit(ScadaError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(ScadaError(message: e.toString()));
    }
  }
}
