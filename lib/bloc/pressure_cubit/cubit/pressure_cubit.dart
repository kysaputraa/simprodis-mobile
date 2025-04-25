import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/pressure_gabung_model.dart';
import 'package:http/http.dart' as http;

part 'pressure_state.dart';

class PressureCubit extends Cubit<PressureState> {
  PressureCubit() : super(PressureInitial());

  void fetchData({required idKelompokPressure}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(PressureLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getPressureByKelompokPressure');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_klp_press_gab": idKelompokPressure},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      PressureGabunganModel data = PressureGabunganModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(PressureSuccess(data: data.data, message: data.message));
      } else {
        emit(PressureError(message: data.message.toString()));
      }
    } catch (e) {
      emit(PressureError(message: e.toString()));
    }
  }

  void fetchData2({required idInstalasi}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(PressureLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getPressureByInstalasi');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": idInstalasi},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      PressureGabunganModel data = PressureGabunganModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(PressureSuccess(data: data.data, message: data.message));
      } else {
        emit(PressureError(message: data.message.toString()));
      }
    } catch (e) {
      emit(PressureError(message: e.toString()));
    }
  }

  void simpan({
    required idKelompokPressure,
    required tanggal,
    required jam,
    required List<String> idPressure,
    required List<String> pressureList,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(PressureLoading());
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
      for (var i = 0; i < idPressure.length; i++) {
        body['pressure[$i]'] = pressureList[i];
        body['id_pressure[$i]'] = idPressure[i];
      }

      Uri url = Uri.parse('${baseUrl}addPressureBatch');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: body,
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(PressureSuccessInsert());
        // fetchData(idKelompokPressure: idKelompokPressure);
      } else {
        emit(PressureError(message: jsonResponse['message'].toString()));
        fetchData(idKelompokPressure: idKelompokPressure);
      }
    } catch (e) {
      emit(PressureError(message: e.toString()));
    }
  }

  void simpan2({
    required tanggal,
    required jam,
    required idPressGab,
    required pressure,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(PressureLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHp = prefs.getString("id_petugas_hp").toString();

      final body = {
        "id_petugas_hp": idPetugasHp,
        "waktu_lapor": tanggal,
        "jam_lapor": jam,
        "tanggal": tanggal,
        "id_press_gab": idPressGab,
        "pressure": pressure,
      };

      Uri url = Uri.parse('${baseUrl}addPressure');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: body,
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(PressureSuccessInsert());
      } else {
        emit(PressureError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(PressureError(message: e.toString()));
    }
  }
}
