import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/pendidikan_model.dart';
import 'package:http/http.dart' as http;
part 'pendidikan_event.dart';
part 'pendidikan_state.dart';

class PendidikanBloc extends Bloc<PendidikanEvent, PendidikanState> {
  PendidikanBloc() : super(PendidikanInitial()) {
    on<PendidikanEvent>((event, emit) async {
      String? baseUrl = dotenv.env['BASE_URL'];

      emit(PendidikanLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String nik = prefs.getString("username").toString();
        String token = prefs.getString("tokenjwt").toString();
        Uri url = Uri.parse('${baseUrl}getPendidikan');
        var response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {"NIK": nik},
        );
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        PendidikanModel data = PendidikanModel.fromMap(jsonResponse);
        if (data.code == 1) {
          emit(PendidikanSucces(data: data));
        } else {
          emit(PendidikanError(message: data.message.toString()));
        }
      } catch (e) {
        emit(PendidikanError(message: e.toString()));
      }
    });
  }
}
