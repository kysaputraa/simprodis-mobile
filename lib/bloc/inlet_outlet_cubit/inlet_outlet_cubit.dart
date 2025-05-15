import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'inlet_outlet_state.dart';

class InletOutletCubit extends Cubit<InletOutletState> {
  InletOutletCubit() : super(InletOutletInitial());

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required phAirBaku,
    required phAirClarif,
    required phAirProduksi,
    required phReservoir1,
    required phReservoir2,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(InletOutletLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addInletOutlet');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        emit(
          InletOutletSuccessInsert(message: jsonResponse['message'].toString()),
        );
      } else {
        emit(InletOutletError(message: jsonResponse['message'].toString()));
      }
    } catch (e) {
      emit(InletOutletError(message: e.toString()));
    }
  }
}
