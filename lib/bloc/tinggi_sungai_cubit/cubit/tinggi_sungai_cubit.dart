import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/tinggi_sungai_model.dart';
import 'package:http/http.dart' as http;

part 'tinggi_sungai_state.dart';

class TinggiSungaiCubit extends Cubit<TinggiSungaiState> {
  TinggiSungaiCubit() : super(TinggiSungaiInitial());
  void fetchData({required id_instalasi, required tanggal}) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(TinggiSungaiLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getTinggiSungaiByInstalasiDate');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": id_instalasi, "tanggal": tanggal},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      TinggiSungaiModel data = TinggiSungaiModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(TinggiSungaiSuccess(data: data.data ?? [], message: data.message));
      } else {
        emit(TinggiSungaiError(message: data.message.toString()));
      }
    } catch (e) {
      emit(TinggiSungaiError(message: e.toString()));
    }
  }

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required tinggi_sungai,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(TinggiSungaiLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String id_petugas_hp = prefs.getString("id_petugas_hp").toString();
      Uri url = Uri.parse('${baseUrl}addTinggiSungai');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": id_petugas_hp,
          "tanggal": tanggal,
          "jam": jam,
          "tinggi_sungai": tinggi_sungai,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
      } else {
        emit(TinggiSungaiError(message: jsonResponse['message'].toString()));
        fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
      }
    } catch (e) {
      emit(TinggiSungaiError(message: e.toString()));
    }
  }
}
