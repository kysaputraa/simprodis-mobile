import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/pelanggan_model.dart';
import 'package:http/http.dart' as http;

part 'pelanggan_state.dart';

class PelangganCubit extends Cubit<PelangganState> {
  PelangganCubit() : super(PelangganInitial());

  void fetchData({required nopam}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(PelangganLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getPelangganByNopam');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"nopam": nopam},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      PelangganModel data = PelangganModel.fromJson(jsonResponse);
      DataPelanggan? dataPelanggan = data.data;
      if (data.code == 1) {
        emit(PelangganSuccess(dataPelanggan: dataPelanggan));
      } else {
        emit(PelangganError(message: data.message.toString()));
      }
    } catch (e) {
      emit(PelangganError(message: e.toString()));
    }
  }
}
