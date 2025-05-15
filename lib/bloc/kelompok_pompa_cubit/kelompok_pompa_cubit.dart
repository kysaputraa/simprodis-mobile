import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/kelompok_pompa_model.dart';
import 'package:http/http.dart' as http;

part 'kelompok_pompa_state.dart';

class KelompokPompaCubit extends Cubit<KelompokPompaState> {
  KelompokPompaCubit() : super(KelompokPompaInitial());

  void fetchData({required id_instalasi}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(KelompokPompaLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getKelompokPompaByInstalasi');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": id_instalasi},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      KelompokPompaModel data = KelompokPompaModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(KelompokPompaSuccess(data: data.data, message: data.message));
      } else {
        emit(KelompokPompaError(message: data.message.toString()));
      }
    } catch (e) {
      emit(KelompokPompaError(message: e.toString()));
    }
  }
}
