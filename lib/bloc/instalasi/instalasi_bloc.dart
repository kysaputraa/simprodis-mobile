import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/instalasi_model.dart';
import 'package:http/http.dart' as http;

part 'instalasi_event.dart';
part 'instalasi_state.dart';

class InstalasiBloc extends Bloc<InstalasiEvent, InstalasiState> {
  InstalasiBloc() : super(InstalasiInitial()) {
    on<InstalasiEventFetch>((event, emit) async {
      String? baseUrl = dotenv.env['BASE_URL'];

      emit(InstalasiLoading());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String username = prefs.getString("username").toString();
        String token = prefs.getString("tokenjwt").toString();
        Uri url = Uri.parse('${baseUrl}getInstalasiByUser');
        var response = await http.post(
          url,
          headers: {'Authorization': 'Bearer $token'},
          body: {"username": username},
        );
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        InstalasiModel data = InstalasiModel.fromJson(jsonResponse);
        if (data.code == 1) {
          emit(InstalasiSucces(data: data));
        } else {
          emit(InstalasiError(message: data.message.toString()));
        }
      } catch (e) {
        emit(InstalasiError(message: e.toString()));
      }
    });
  }
}
