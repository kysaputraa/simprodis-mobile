import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/instalasi_model.dart';
import 'package:http/http.dart' as http;

part 'instalasi_state.dart';

class InstalasiCubit extends Cubit<InstalasiState> {
  InstalasiCubit() : super(InstalasiInitial());

  void fetchData(String kelompokInstalasi) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(InstalasiLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String id_petugas_hp = prefs.getString("id_petugas_hp").toString();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getInstalasiByUser');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_petugas_hp": id_petugas_hp,
          'kelompokInstalasi': kelompokInstalasi,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      InstalasiModel data = InstalasiModel.fromJson(jsonResponse);
      if (data.code == 1) {
        emit(
          InstalasiSuccess(
            data: data.data,
            selectedJenisInstalasi: kelompokInstalasi,
          ),
        );
      } else {
        emit(InstalasiError(message: data.message.toString()));
      }
    } catch (e) {
      emit(InstalasiError(message: e.toString()));
    }
  }

  void selectInstalasi(String item) {
    if (state is InstalasiSuccess) {
      final currentState = state as InstalasiSuccess;
      emit(
        InstalasiSuccess(
          data: currentState.data,
          selectedInstalasi: item,
          selectedJam: currentState.selectedJam,
          selectedTanggal: currentState.selectedTanggal,
          selectedJenisInstalasi: currentState.selectedJenisInstalasi,
        ),
      );
    }
  }

  void selectJenisInstalasi(String item) {
    if (state is InstalasiSuccess) {
      final currentState = state as InstalasiSuccess;
      emit(
        InstalasiSuccess(
          data: currentState.data,
          selectedInstalasi: currentState.selectedInstalasi,
          selectedJam: currentState.selectedJam,
          selectedTanggal: currentState.selectedTanggal,
          selectedJenisInstalasi: item,
        ),
      );
    }
  }

  void selectJam(String item) {
    if (state is InstalasiSuccess) {
      final currentState = state as InstalasiSuccess;
      emit(
        InstalasiSuccess(
          data: currentState.data,
          selectedInstalasi: currentState.selectedInstalasi,
          selectedJam: item,
          selectedTanggal: currentState.selectedTanggal,
          selectedJenisInstalasi: currentState.selectedJenisInstalasi,
        ),
      );
    }
  }

  void selectTanggal(String item) {
    if (state is InstalasiSuccess) {
      final currentState = state as InstalasiSuccess;
      emit(
        InstalasiSuccess(
          data: currentState.data,
          selectedInstalasi: currentState.selectedInstalasi,
          selectedJam: currentState.selectedJam,
          selectedTanggal: item,
          selectedJenisInstalasi: currentState.selectedJenisInstalasi,
        ),
      );
    }
  }
}
