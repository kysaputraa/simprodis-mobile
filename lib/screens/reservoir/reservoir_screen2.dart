import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/reservoir_cubit/cubit/reservoir_cubit.dart';

class ReservoirScreen2 extends StatefulWidget {
  const ReservoirScreen2({super.key});

  @override
  State<ReservoirScreen2> createState() => ReservoirScreen2State();
}

class ReservoirScreen2State extends State<ReservoirScreen2> {
  String? selectedPressGab;
  final TextEditingController tinggiController = TextEditingController();

  Widget build(BuildContext context) {
    final pressureCubit = ReservoirCubit();
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
                  'Tinggi Reservoir',
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
                        builder: (ReservoirCubit, ReservoirState) {
                          if (ReservoirState is ReservoirSuccess) {
                            if (ReservoirState.data.isEmpty) {
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
                                labelText: 'Pilih Kelompok Reservoir',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              items:
                                  ReservoirState.data.map<
                                    DropdownMenuItem<String>
                                  >((item) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          item.idReservoir, // Adjust the key based on your data structure
                                      child: Text(
                                        item.namaReservoir
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
                          } else if (ReservoirState is ReservoirLoading) {
                            return Center(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (ReservoirState is ReservoirError) {
                            return Center(
                              child: Text("Gagal: ${ReservoirState.message}"),
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
                                  child: Text("Tinggi (cm): "),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: tinggiController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Tinggi (cm)',
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
                      child: BlocConsumer<ReservoirCubit, ReservoirState>(
                        bloc: pressureCubit,
                        listener: (context, stateReservoir) {
                          if (stateReservoir is ReservoirSuccessInsert) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Data berhasil disimpan"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop();
                          } else if (stateReservoir is ReservoirError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Gagal : ${stateReservoir.message}",
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, stateReservoir) {
                          if (stateReservoir is ReservoirLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ElevatedButton.icon(
                              onPressed: () {
                                if (selectedPressGab != null &&
                                    tinggiController.text.isNotEmpty) {
                                  pressureCubit.simpan2(
                                    idInstalasi: state.selectedInstalasi,
                                    tanggal: state.selectedTanggal,
                                    jam: state.selectedJam,
                                    idPressGab: selectedPressGab,
                                    tinggi: tinggiController.text,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Silahkan isi semua data "),
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
