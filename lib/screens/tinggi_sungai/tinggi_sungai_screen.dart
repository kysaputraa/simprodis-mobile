import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/tinggi_sungai_cubit/cubit/tinggi_sungai_cubit.dart';

class TinggiSungaiScreen extends StatelessWidget {
  const TinggiSungaiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController tinggiSungaiController =
        TextEditingController();

    final tinggiSungaiCubit = TinggiSungaiCubit();

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
                  'Tinggi Sungai',
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
            tinggiSungaiCubit.fetchData(
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
                          // Text(
                          //   "Stand KWH",
                          //   style: TextStyle(
                          //     color: Color.fromRGBO(0, 81, 135, 1),
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Tinggi Sungai : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: tinggiSungaiController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Tinggi Sungai',
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
                              child: BlocConsumer<
                                TinggiSungaiCubit,
                                TinggiSungaiState
                              >(
                                bloc: tinggiSungaiCubit,
                                listener: (context, stateTinggiSungai) {
                                  if (stateTinggiSungai is TinggiSungaiError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Gagal : ${stateTinggiSungai.message.toString()}",
                                        ),
                                      ),
                                    );
                                  } else if (stateTinggiSungai
                                      is TinggiSungaiSuccessInsert) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Sukses : ${stateTinggiSungai.message.toString()}",
                                        ),
                                      ),
                                    );
                                    context.pop();
                                  }
                                },
                                builder: (context, stateTinggiSungai) {
                                  if (stateTinggiSungai
                                      is TinggiSungaiLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        tinggiSungaiCubit.simpan(
                                          id_instalasi: state.selectedInstalasi,
                                          tanggal: state.selectedTanggal,
                                          jam: state.selectedJam,
                                          tinggi_sungai:
                                              tinggiSungaiController.text
                                                  .toString(),
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
                  //     child: BlocBuilder<TinggiSungaiCubit, TinggiSungaiState>(
                  //       bloc: tinggiSungaiCubit,
                  //       builder: (context, stateKWH) {
                  //         if (stateKWH is TinggiSungaiSuccess) {
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
                  //               color: Colors.grey,
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
                  //                       'Tinggi',
                  //                       style: TextStyle(
                  //                         fontWeight: FontWeight.bold,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),

                  //               // Table rows from stateKWH.data
                  //               ...stateKWH.data.asMap().entries.map((entry) {
                  //                 final index = entry.key;
                  //                 final data = entry.value;

                  //                 return TableRow(
                  //                   children: [
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text((index + 1).toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(data.waktuLapor.toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(data.jamLapor.toString()),
                  //                     ),
                  //                     Padding(
                  //                       padding: const EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         data.tinggiSungai.toString(),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 );
                  //               }).toList(),
                  //             ],
                  //           );
                  //         } else if (stateKWH is TinggiSungaiLoading) {
                  //           return Center(child: CircularProgressIndicator());
                  //         } else if (stateKWH is TinggiSungaiError) {
                  //           return Center(
                  //             child: Text("Error: ${stateKWH.message}"),
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
