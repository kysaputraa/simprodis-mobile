import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/flowmeter_model.dart';
import 'package:http/http.dart' as http;

part 'flowmeter_state.dart';

class FlowmeterCubit extends Cubit<FlowmeterState> {
  FlowmeterCubit() : super(FlowmeterInitial());

  void fetchData({required idInstalasi}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(FlowmeterLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getFlowmeterByInstalasi');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": idInstalasi},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      FlowmeterModel data = FlowmeterModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(FlowmeterSuccess(data: data.data!, message: data.message));
      } else {
        emit(FlowmeterError(message: data.message.toString()));
      }
    } catch (e) {
      emit(FlowmeterError(message: e.toString()));
    }
  }

  void simpan({
    required tanggal,
    required jam,
    required idFlowmeter,
    required debit,
    required standMeter,
    required idInstalasi,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(FlowmeterLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHp = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();

      final body = {
        "id_petugas_hp": idPetugasHp,
        "waktu_lapor": tanggal,
        "jam_lapor": jam,
        "tanggal": tanggal,
        "id_flowmeter": idFlowmeter,
        "debit": debit,
        "stand_meter": standMeter,
        "username": username,
      };

      Uri url = Uri.parse('${baseUrl}addFlowmeter');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: body,
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(FlowmeterSuccessInsert());
      } else {
        emit(FlowmeterError(message: jsonResponse['message'].toString()));
        fetchData(idInstalasi: idInstalasi);
      }
    } catch (e) {
      emit(FlowmeterError(message: e.toString()));
    }
  }
}
