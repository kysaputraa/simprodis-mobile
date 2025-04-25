import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simprodis_flutter/model/berkala_model.dart';
part 'berkala_event.dart';
part 'berkala_state.dart';

class BerkalaBloc extends Bloc<BerkalaEvent, BerkalaState> {
  BerkalaBloc() : super(BerkalaInitial()) {
    on<BerkalaEventFetch>((event, emit) async {
      String? baseUrl = dotenv.env['BASE_URL'];

      emit(BerkalaLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String nik = prefs.getString("username").toString();
        String token = prefs.getString("tokenjwt").toString();
        Uri url = Uri.parse('${baseUrl}getBerkala');
        var response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {"NIK": nik},
        );
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        BerkalaModel data = BerkalaModel.fromMap(jsonResponse);
        if (data.code == 1) {
          emit(BerkalaSucces(data: data));
        } else {
          emit(BerkalaError(message: data.message.toString()));
        }
      } catch (e) {
        emit(BerkalaError(message: e.toString()));
      }
    });
  }
}
