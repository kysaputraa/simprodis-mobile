import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:simprodis_flutter/routes/router.dart';

class KelompokStandMeterScreen extends StatefulWidget {
  const KelompokStandMeterScreen({super.key});

  @override
  State<KelompokStandMeterScreen> createState() =>
      _KelompokStandMeterScreenState();
}

class _KelompokStandMeterScreenState extends State<KelompokStandMeterScreen> {
  late Future<List<dynamic>> listKelompokStandMeter;
  String? selectedKelompok;
  String? selectedNamaKelompok;
  String? jumlahKelompok;

  Future<List<dynamic>> fetchData(String id) async {
    String? baseUrl = dotenv.env['BASE_URL'];

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("tokenjwt").toString();
      Uri url = Uri.parse('${baseUrl}getKelompokStandMeterAirByInstalasi');
      var response = await http.post(
        url,
        headers: {'Authorization': 'Bearer $token'},
        body: {"id_instalasi": id},
      );

      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['code'] == 1) {
        return jsonResponse['data'];
      } else {
        return jsonResponse['data'];
      }
    } catch (e) {
      inspect(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(0, 81, 135, 1), Colors.white],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "IPA",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Kelompok Stand Meter Air',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(0, 81, 135, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        toolbarHeight: 120.0, // Adjust the height of the AppBar
        // flexibleSpace: Center(child: Text("data")),
        centerTitle: false, // We are manually centering it here
      ),
      body: BlocBuilder<InstalasiCubit, InstalasiState>(
        builder: (context, state) {
          if (state is InstalasiSuccess && state.selectedInstalasi != null) {
            listKelompokStandMeter = fetchData(
              state.selectedInstalasi.toString(),
            );
            final displayName =
                state.data
                    .firstWhere(
                      (instalasi) =>
                          instalasi.idInstalasi == state.selectedInstalasi,
                    )
                    .namaInstalasi;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 240, 240, 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Instalasi",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 81, 135, 1),
                                ),
                              ),
                              // Text(
                              //   "Jumlah Kelompok Press Gab : ${jumlahKelompok}",
                              //   style: TextStyle(
                              //     color: Color.fromRGBO(0, 81, 135, 1),
                              //   ),
                              // ),
                            ],
                          ),
                          BlocBuilder<InstalasiCubit, InstalasiState>(
                            builder: (context, state) {
                              if (state is InstalasiSuccess) {
                                return Text(
                                  '$displayName',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 81, 135, 1),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Text("Failed to load !");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder<List<dynamic>>(
                        future:
                            listKelompokStandMeter, // Provide the future to FutureBuilder
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            return DropdownButtonFormField<dynamic>(
                              value: selectedKelompok,
                              decoration: InputDecoration(
                                labelText: 'Select Item',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              isExpanded: true, // Add this line
                              items:
                                  snapshot.data!.map<DropdownMenuItem<dynamic>>(
                                    (item) {
                                      return DropdownMenuItem<dynamic>(
                                        value: item['id_klp_meter'],
                                        child: SizedBox(
                                          child: Text(
                                            item['nama_klp_meter'],
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                              onChanged: (value) {
                                log('Selected value: $value');
                                setState(() {
                                  selectedKelompok = value;
                                  selectedNamaKelompok =
                                      snapshot.data!.firstWhere(
                                        (item) => item['id_klp_meter'] == value,
                                      )['nama_klp_meter'];
                                });
                              },
                            );
                          } else {
                            return Center(child: Text('No data available.'));
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          context.pushNamed(
                            Routes.standMeterScreen,
                            queryParameters: {
                              'idKelompok': '$selectedKelompok',
                              'namaKelompok': '$selectedNamaKelompok',
                            },
                          );
                        },
                        icon: Icon(Icons.arrow_forward, color: Colors.white),
                        label: Text(
                          'Lanjut',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          textStyle: TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ), // Set the radius here
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 4,
                          shadowColor: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is InstalasiLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is InstalasiError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return Center(child: Text("Gagal"));
          }
        },
      ),
    );
  }
}
