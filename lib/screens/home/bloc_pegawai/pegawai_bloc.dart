import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simprodis_flutter/model/pegawai_detail.dart';
part 'pegawai_event.dart';
part 'pegawai_state.dart';

class PegawaiBloc extends Bloc<PegawaiEvent, PegawaiState> {
  PegawaiBloc() : super(PegawaiInitial()) {
    on<PegawaiEventFetch>((event, emit) async {
      String? baseUrl = dotenv.env['BASE_URL'];

      emit(PegawaiLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String username = prefs.getString("username").toString();
        String token = prefs.getString("tokenjwt").toString();
        Uri url = Uri.parse('${baseUrl}detailpegawai');
        var response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {"username": username},
        );
        // inspect(username);
        // print('token : ${token} , nik : ${nik}');
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        PegawaiModel data = PegawaiModel.fromJson(jsonResponse);
        if (data.code == 1) {
          emit(PegawaiSuccess(data: data));
        } else {
          emit(PegawaiError(message: data.message.toString()));
        }
      } catch (e) {
        emit(PegawaiError(message: e.toString()));
      }
    });
  }
}
