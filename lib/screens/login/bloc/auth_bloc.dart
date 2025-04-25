import 'dart:convert' as convert;
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEventLogin>((event, emit) async {
      String? baseUrl = dotenv.env['BASE_URL'];
      try {
        emit(AuthLoading());
        Uri url = Uri.parse('https://si-monitoring.tirtamayang.com/auth');
        var response = await http.post(
          url,
          body: {"username": event.username, "password": event.password},
        );
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (response.statusCode == 200) {
          emit(
            AuthSuccess(
              token: jsonResponse['token'].toString(),
              username: jsonResponse['username'].toString(),
              message: jsonResponse['message'].toString(),
              id_petugas_hp: jsonResponse['id_petugas_hp'].toString(),
              code: jsonResponse['code'].toString(),
            ),
          );
          SharedPreferences prefs;
          prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("tokenjwt", jsonResponse['token'].toString());
          prefs.setString("username", jsonResponse['username'].toString());
          prefs.setString(
            "id_petugas_hp",
            jsonResponse['id_petugas_hp'].toString(),
          );
        } else {
          emit(AuthError(message: jsonResponse['message'].toString()));
        }
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<AuthEventLogout>((event, emit) async {
      emit(AuthLoading());
      try {
        SharedPreferences prefs;
        prefs = await SharedPreferences.getInstance();
        prefs.clear();
        emit(AuthLogout());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
