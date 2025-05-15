import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/pressure_cubit/cubit/pressure_cubit.dart';

class PressureScreen2 extends StatefulWidget {
  const PressureScreen2({super.key});

  @override
  State<PressureScreen2> createState() => PressureScreen2State();
}

class PressureScreen2State extends State<PressureScreen2> {
  String? selectedPressGab;
  final TextEditingController pressureController = TextEditingController();

  Widget build(BuildContext context) {
    final pressureCubit = PressureCubit();
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
                BlocBuilder<InstalasiCubit, InstalasiState>(
                  builder: (context, state) {
                    if (state is InstalasiSuccess) {
                      return Text(
                        "${state.selectedJenisInstalasi}".toUpperCase(),
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    } else if (state is InstalasiLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Center(child: Text("Gagal"));
                    }
                  },
                ),
                Text(
                  'Kelompok Press Gab',
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
            final displayName =
                state.data
                    .firstWhere(
                      (instalasi) =>
                          instalasi.idInstalasi == state.selectedInstalasi,
                    )
                    .namaInstalasi;
            pressureCubit.fetchData2(idInstalasi: state.selectedInstalasi);
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
                      child: BlocBuilder(
                        bloc: pressureCubit,
                        builder: (PressureCubit, PressureState) {
                          if (PressureState is PressureSuccess) {
                            if (PressureState.data.isEmpty) {
                              return Center(
                                child: Text(
                                  'Tidak ada instalasi tersedia',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            return DropdownButtonFormField<String>(
                              value: selectedPressGab,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: 'Pilih Pressure Gabungan',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              items:
                                  PressureState.data.map<
                                    DropdownMenuItem<String>
                                  >((item) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          item.idPressGab, // Adjust the key based on your data structure
                                      child: Text(
                                        item.namaPressGab
                                            .toString(), // Adjust the key based on your data structure
                                      ), // Adjust the key based on your data structure
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  log(value.toString());
                                  selectedPressGab = value;
                                });
                              },
                            );
                          } else if (PressureState is PressureLoading) {
                            return Center(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (PressureState is PressureError) {
                            return Center(
                              child: Text("Gagal: ${PressureState.message}"),
                            );
                          } else {
                            return Center(child: Text("Failed to load !"));
                          }
                        },
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Pressure (atm) : "),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: pressureController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Pressure (atm)',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: BlocConsumer<PressureCubit, PressureState>(
                        bloc: pressureCubit,
                        listener: (context, statePressure) {
                          if (statePressure is PressureSuccessInsert) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Data berhasil disimpan"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop();
                          } else if (statePressure is PressureError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Gagal : ${statePressure.message}",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, statePressure) {
                          if (statePressure is PressureLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ElevatedButton.icon(
                              onPressed: () {
                                if (selectedPressGab != null &&
                                    pressureController.text.isNotEmpty) {
                                  pressureCubit.simpan2(
                                    idInstalasi: state.selectedInstalasi,
                                    tanggal: state.selectedTanggal,
                                    jam: state.selectedJam,
                                    idPressGab: selectedPressGab,
                                    pressure: pressureController.text,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Silahkan pilih pressure gabungan",
                                      ),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              icon: Icon(Icons.save, color: Colors.white),
                              label: Text(
                                'Simpan',
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
                            );
                          }
                        },
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
