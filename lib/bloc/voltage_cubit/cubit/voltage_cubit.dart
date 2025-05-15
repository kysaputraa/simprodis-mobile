import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/voltage_model.dart';
import 'package:http/http.dart' as http;
part 'voltage_state.dart';

class VoltageCubit extends Cubit<VoltageState> {
  VoltageCubit() : super(VoltageInitial());

  void fetchData({required id_instalasi, required tanggal}) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(VoltageLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getVoltageByInstalasiDate');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": id_instalasi, "tanggal": tanggal},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      VoltageModel data = VoltageModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(VoltageSuccess(data: data.data ?? [], message: data.message));
      } else {
        emit(VoltageError(message: data.message.toString()));
      }
    } catch (e) {
      emit(VoltageError(message: e.toString()));
    }
  }

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required volt_rn,
    required volt_rs,
    required volt_st,
    required volt_rt,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(VoltageLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String id_petugas_hp = prefs.getString("id_petugas_hp").toString();
      Uri url = Uri.parse('${baseUrl}addVoltage');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": id_petugas_hp,
          "tanggal": tanggal,
          "jam": jam,
          "volt_rn": volt_rn,
          "volt_rs": volt_rs,
          "volt_st": volt_st,
          "volt_rt": volt_rt,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        // fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
        emit(VoltageSuccessInsert(message: jsonResponse['message']));
      } else {
        emit(VoltageError(message: jsonResponse['message'].toString()));
        fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
      }
    } catch (e) {
      emit(VoltageError(message: e.toString()));
    }
  }
}
