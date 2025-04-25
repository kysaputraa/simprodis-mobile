import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/pompa_model.dart';
import 'package:http/http.dart' as http;

part 'pompa_state.dart';

class PompaCubit extends Cubit<PompaState> {
  PompaCubit() : super(PompaInitial());

  void fetchData({required idKelompokPompa}) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(PompaLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getPompaByKelompokPompa');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_klp_pompa": idKelompokPompa},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      PompaModel data = PompaModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(PompaSuccess(data: data.data, message: data.message));
      } else {
        emit(PompaError(message: data.message.toString()));
      }
    } catch (e) {
      emit(PompaError(message: e.toString()));
    }
  }

  void simpan({
    required idKelompokPompa,
    required tanggal,
    required jam,
    required List<String> idPompa,
    required List<String> amphereList,
    required List<String> speedList,
    required List<String> pressureList,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(PompaLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String id_petugas_hp = prefs.getString("id_petugas_hp").toString();

      final body = {
        "id_petugas_hp": id_petugas_hp,
        "waktu_lapor": tanggal,
        "jam_lapor": jam,
        "tanggal": tanggal,
      };
      for (var i = 0; i < amphereList.length; i++) {
        body['amphere[$i]'] = amphereList[i];
        body['speed[$i]'] = speedList[i];
        body['pressure[$i]'] = pressureList[i];
        body['id_pompa[$i]'] = idPompa[i];
      }

      Uri url = Uri.parse('${baseUrl}addPompaBatch');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: body,
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(PompaSuccessInsert());
        // fetchData(idKelompokPompa: idKelompokPompa);
      } else {
        emit(PompaError(message: jsonResponse['message'].toString()));
        fetchData(idKelompokPompa: idKelompokPompa);
      }
    } catch (e) {
      emit(PompaError(message: e.toString()));
    }
  }
}
