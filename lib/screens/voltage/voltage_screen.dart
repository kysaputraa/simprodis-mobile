import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/kwh_cubit/kwh_cubit.dart';
import 'package:simprodis_flutter/bloc/voltage_cubit/cubit/voltage_cubit.dart';

class VolatageScreen extends StatelessWidget {
  const VolatageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController volt_rn = TextEditingController();
    final TextEditingController volt_rs = TextEditingController();
    final TextEditingController volt_st = TextEditingController();
    final TextEditingController volt_rt = TextEditingController();

    final voltageCubit = VoltageCubit();

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
                  "INTAKE",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'kWh',
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
            voltageCubit.fetchData(
              id_instalasi: state.selectedInstalasi,
              tanggal: state.selectedTanggal,
            );
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
                          Text(
                            "Instalasi",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 81, 135, 1),
                            ),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Stand KWH",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 81, 135, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("RN : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: volt_rn,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Volt RN',
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
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("RS : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: volt_rs,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Volt RS',
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
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("ST : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: volt_st,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Volt ST',
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
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("RT : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: volt_rt,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Volt RT',
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
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: BlocConsumer<VoltageCubit, VoltageState>(
                                bloc: voltageCubit,
                                listener: (context, stateVoltage) {
                                  if (stateVoltage is VoltageError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Gagal : ${stateVoltage.message.toString()}",
                                        ),
                                      ),
                                    );
                                  } else if (stateVoltage
                                      is VoltageSuccessInsert) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Sukses : ${stateVoltage.message.toString()}",
                                        ),
                                      ),
                                    );
                                    context.pop();
                                  }
                                },
                                builder: (context, stateVoltage) {
                                  if (stateVoltage is VoltageLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        voltageCubit.simpan(
                                          id_instalasi: state.selectedInstalasi,
                                          tanggal: state.selectedTanggal,
                                          jam: state.selectedJam,
                                          volt_rn: volt_rn.text.toString(),
                                          volt_rs: volt_rs.text.toString(),
                                          volt_st: volt_st.text.toString(),
                                          volt_rt: volt_rt.text.toString(),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        "Simpan",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Color.fromRGBO(250, 250, 250, 1),
                  //       borderRadius: BorderRadius.circular(8),
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black26,
                  //           blurRadius: 4,
                  //           offset: Offset(2, 2),
                  //         ),
                  //       ],
                  //     ),
                  //     padding: EdgeInsets.all(10),
                  //     width: MediaQuery.of(context).size.width,
                  //     child: BlocBuilder<VoltageCubit, VoltageState>(
                  //       bloc: voltageCubit,
                  //       builder: (context, stateVoltage) {
                  //         if (stateVoltage is VoltageSuccess) {
                  //           return Table(
                  //             columnWidths: const {
                  //               0: FlexColumnWidth(1),
                  //               1: FlexColumnWidth(2),
                  //               2: FlexColumnWidth(2),
                  //               3: FlexColumnWidth(2),
                  //               4: FlexColumnWidth(2),
                  //             },
                  //             border: TableBorder.all(
                  //               width: 1.0,
                  //               color: const Color.fromRGBO(158, 158, 158, 1),
                  //             ),
                  //             children: [
                  //               // Table header
                  //               TableRow(
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.grey[300],
                  //                 ),
                  //                 children: const [
                  //                   Padding(
                  //                     padding: EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       'No',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       'Tanggal',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       'Jam',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       'RN',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       'RS',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       'ST',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: EdgeInsets.all(8.0),
                  //                     child: Text(
                  //                       'RT',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),

                  //               // Table rows from stateVoltage.data
                  //               ...stateVoltage.data.asMap().entries.map((
                  //                 entry,
                  //               ) {
                  //                 final index = entry.key;
                  //                 final data = entry.value;

                  //                 return TableRow(
                  //                   children: [
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(5),
                  //                       child: Text((index + 1).toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(5),
                  //                       child: Text(data.waktuLapor.toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(5),
                  //                       child: Text(data.jamLapor.toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(5),
                  //                       child: Text(data.voltRn.toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(5),
                  //                       child: Text(data.voltRs.toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(5),
                  //                       child: Text(data.voltRt.toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(5),
                  //                       child: Text(data.voltSt.toString()),
                  //                     ),
                  //                   ],
                  //                 );
                  //               }).toList(),
                  //             ],
                  //           );
                  //         } else if (stateVoltage is VoltageLoading) {
                  //           return Center(child: CircularProgressIndicator());
                  //         } else if (stateVoltage is VoltageError) {
                  //           return Center(
                  //             child: Text("Error: ${stateVoltage.message}"),
                  //           );
                  //         } else {
                  //           return Center(child: Text("Gagal"));
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
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
