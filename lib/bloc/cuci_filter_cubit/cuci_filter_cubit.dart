import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/model/cuci_filter_model.dart';

part 'cuci_filter_state.dart';

class CuciFilterCubit extends Cubit<CuciFilterState> {
  CuciFilterCubit() : super(CuciFilterInitial());

  void fetchData({required idInstalasi}) async {
    String? baseUrl = dotenv.env['BASE_URL'];
    emit(CuciFilterLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getCuciFilterByInstalasi');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": idInstalasi},
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      CuciFilterModel data = CuciFilterModel.fromJson(jsonResponse);
      DataCuciFilter? dataCuciFilter = data.data;
      int jumlah = 0;
      if (dataCuciFilter != null && dataCuciFilter.jumlahFilter != null) {
        jumlah = int.parse(dataCuciFilter.jumlahFilter!);
      }
      List<int> clarifList = List<int>.generate(jumlah, (index) => index + 1);

      if (data.code == 1) {
        emit(CuciFilterSuccess(data: clarifList, message: data.message));
      } else {
        emit(CuciFilterError(message: data.message.toString()));
      }
    } catch (e) {
      emit(CuciFilterError(message: e.toString()));
    }
  }

  void simpan({
    required id_instalasi,
    required tanggal,
    required jam,
    required cuci_filter,
  }) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    emit(CuciFilterLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      String idPetugasHP = prefs.getString("id_petugas_hp").toString();
      String username = prefs.getString("username").toString();
      Uri url = Uri.parse('${baseUrl}addCuciFilter');
      String cuciFilterString = cuci_filter.join(',');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "id_instalasi": id_instalasi,
          "id_petugas_hp": idPetugasHP,
          "waktu_lapor": tanggal,
          "jam_lapor": jam,
          "cuci_filter": cuciFilterString,
          "username": username,
        },
      );
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        // fetchData(id_instalasi: id_instalasi, tanggal: tanggal);
        emit(
          CuciFilterSuccessInsert(message: jsonResponse['message'].toString()),
        );
      } else {
        // String messageString;
        // if (jsonResponse['message'] is List) {
        //   messageString = jsonResponse['message'].join(', ');
        // } else if (jsonResponse['message'] != null) {
        //   messageString = jsonResponse['message'].toString();
        // } else {
        //   messageString = '';
        // }
        emit(CuciFilterError(message: jsonResponse['message'].toString()));
        fetchData(idInstalasi: id_instalasi);
      }
    } catch (e) {
      emit(CuciFilterError(message: e.toString()));
    }
  }

  void selectItems(List<String> item) {
    if (state is CuciFilterSuccess) {
      final currentState = state as CuciFilterSuccess;
      emit(CuciFilterSuccess(data: currentState.data, selectedItems: item));
    }
  }
}
