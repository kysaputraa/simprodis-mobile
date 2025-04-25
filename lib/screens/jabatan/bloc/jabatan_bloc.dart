import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/jabatan_model.dart';
import 'package:http/http.dart' as http;
part 'jabatan_event.dart';
part 'jabatan_state.dart';

class JabatanBloc extends Bloc<JabatanEvent, JabatanState> {
  JabatanBloc() : super(JabatanInitial()) {
    on<JabatanEventFetch>((event, emit) async {
      String? baseUrl = dotenv.env['BASE_URL'];

      emit(JabatanLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String nik = prefs.getString("username").toString();
        String token = prefs.getString("tokenjwt").toString();
        Uri url = Uri.parse('${baseUrl}getTrJabatan');
        var response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {"NIK": nik},
        );
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        JabatanModel data = JabatanModel.fromMap(jsonResponse);
        if (data.code == 1) {
          emit(JabatanSucces(data: data));
        } else {
          emit(JabatanError(message: data.message.toString()));
        }
      } catch (e) {
        emit(JabatanError(message: e.toString()));
      }
    });
  }
}
