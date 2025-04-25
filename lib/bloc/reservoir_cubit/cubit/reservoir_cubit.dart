import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/reservoir_model.dart';
import 'package:http/http.dart' as http;

part 'reservoir_state.dart';

class ReservoirCubit extends Cubit<ReservoirState> {
  ReservoirCubit() : super(ReservoirInitial());

  void fetchData({required idKelompokReservoir}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(ReservoirLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getReservoirByKelompokReservoir');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_klp_reservoir": idKelompokReservoir},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      ReservoirModel data = ReservoirModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(ReservoirSuccess(data: data.data!, message: data.message));
      } else {
        emit(ReservoirError(message: data.message.toString()));
      }
    } catch (e) {
      emit(ReservoirError(message: e.toString()));
    }
  }

  void simpan({
    required idKelompokReservoir,
    required tanggal,
    required jam,
    required List<String> idReservoir,
    required List<String> tinggiList,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(ReservoirLoading());
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
      for (var i = 0; i < idReservoir.length; i++) {
        body['tinggi[$i]'] = tinggiList[i];
        body['id_reservoir[$i]'] = idReservoir[i];
      }

      Uri url = Uri.parse('${baseUrl}addReservoirBatch');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: body,
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(ReservoirSuccessInsert());
        // fetchData(idKelompokReservoir: idKelompokReservoir);
      } else {
        emit(ReservoirError(message: jsonResponse['message'].toString()));
        fetchData(idKelompokReservoir: idKelompokReservoir);
      }
    } catch (e) {
      emit(ReservoirError(message: e.toString()));
    }
  }
}
