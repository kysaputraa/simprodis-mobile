import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
part 'bahan_kimia_state.dart';

class BahanKimiaCubit extends Cubit<BahanKimiaState> {
  BahanKimiaCubit() : super(BahanKimiaInitial());

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required penetral,
    required koagulan,
    required desinfektan,
    required konsKoagulan,
    required scm,
    required frekKoagulan,
    required frekPenetral,
    required frekDesinfektan,
    required tinggiPenyimpananKoagulan,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(BahanKimiaLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addBahanKimia');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          "isi_penetral": penetral,
          "isi_koagulan": koagulan,
          "isi_desinfektan": desinfektan,
          "kons_koagulan_campuran": konsKoagulan,
          "scm": scm,
          "frek_pompa_koagulan": frekKoagulan,
          "frek_pompa_penetral": frekPenetral,
          "frek_pompa_desinfektan": frekDesinfektan,
          "tinggi_penyimpanan_koagulan": tinggiPenyimpananKoagulan,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        // fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
        emit(
          BahanKimiaSuccessInsert(message: jsonResponse['message'].toString()),
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
        emit(BahanKimiaError(message: jsonResponse['message'].toString()));
        // fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
      }
    } catch (e) {
      emit(BahanKimiaError(message: e.toString()));
    }
  }
}
