import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/stand_meter_model.dart';
import 'package:http/http.dart' as http;

part 'stand_meter_state.dart';

class StandMeterCubit extends Cubit<StandMeterState> {
  StandMeterCubit() : super(StandMeterInitial());

  void fetchData({required idKelompokStandMeter}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(StandMeterLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getStandMeterAirByKelompokStandMeterAir');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_klp_meter": idKelompokStandMeter},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      StandMeterModel data = StandMeterModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(StandMeterSuccess(data: data.data!, message: data.message));
      } else {
        emit(StandMeterError(message: data.message.toString()));
      }
    } catch (e) {
      emit(StandMeterError(message: e.toString()));
    }
  }

  void simpan({
    required idKelompokStandMeter,
    required tanggal,
    required jam,
    required List<String> idStandMeter,
    required List<String> standMeterList,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(StandMeterLoading());
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
      for (var i = 0; i < idStandMeter.length; i++) {
        body['stand_meter[$i]'] = standMeterList[i];
        body['id_meter[$i]'] = idStandMeter[i];
      }

      Uri url = Uri.parse('${baseUrl}addStandMeterAirBatch');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: body,
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(StandMeterSuccessInsert());
        // fetchData(idKelompokStandMeter: idKelompokStandMeter);
      } else {
        emit(StandMeterError(message: jsonResponse['message'].toString()));
        fetchData(idKelompokStandMeter: idKelompokStandMeter);
      }
    } catch (e) {
      emit(StandMeterError(message: e.toString()));
    }
  }
}
