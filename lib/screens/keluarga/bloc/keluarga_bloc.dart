import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/keluarga_model.dart';

part 'keluarga_event.dart';
part 'keluarga_state.dart';

class KeluargaBloc extends Bloc<KeluargaEvent, KeluargaState> {
  KeluargaBloc() : super(KeluargaInitial()) {
    on<KeluargaEventFetch>((event, emit) async {
      String? baseUrl = dotenv.env['BASE_URL'];

      emit(KeluargaLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String nik = prefs.getString("username").toString();
        String token = prefs.getString("tokenjwt").toString();
        Uri url = Uri.parse('${baseUrl}getKeluarga');
        var response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {"NIK": nik},
        );
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        KeluargaModel data = KeluargaModel.fromMap(jsonResponse);
        if (data.code == 1) {
          emit(KeluargaSucces(data: data));
        } else {
          emit(KeluargaError(message: data.message.toString()));
        }
      } catch (e) {
        emit(KeluargaError(message: e.toString()));
      }
    });
  }
}
