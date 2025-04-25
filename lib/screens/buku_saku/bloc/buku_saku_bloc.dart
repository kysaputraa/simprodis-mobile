import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/skdireksi_model.dart';
import 'package:http/http.dart' as http;
part 'buku_saku_event.dart';
part 'buku_saku_state.dart';

class BukuSakuBloc extends Bloc<BukuSakuEvent, BukuSakuState> {
  BukuSakuBloc() : super(BukuSakuInitial()) {
    on<BukuSakuEvent>((event, emit) async {
      String? baseUrl = dotenv.env['BASE_URL'];

      emit(BukuSakuLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("tokenjwt").toString();
        Uri url = Uri.parse('${baseUrl}getSkDireksi');
        var response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
        );
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        SkDireksiModel data = SkDireksiModel.fromMap(jsonResponse);
        if (data.code == 1) {
          emit(BukuSakuSuccess(data: data));
        } else {
          emit(BukuSakuError(message: data.message.toString()));
        }
      } catch (e) {
        emit(BukuSakuError(message: e.toString()));
      }
    });
  }
}
