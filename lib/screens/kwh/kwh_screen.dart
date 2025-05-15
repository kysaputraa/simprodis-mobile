import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/kwh_cubit/kwh_cubit.dart';

class KwhScreen extends StatelessWidget {
  const KwhScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController wbp = TextEditingController();
    final TextEditingController lwbp = TextEditingController();
    final TextEditingController kvarh = TextEditingController();

    final kwhCubit = KwhCubit();

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
            kwhCubit.fetchData(
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
                                  child: Text("LWBP : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: lwbp,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'LWBP',
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
                                  child: Text("WBP : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: wbp,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'WBP',
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
                                  child: Text("KVARH : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: kvarh,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'KVARH',
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
                              child: BlocConsumer<KwhCubit, KwhState>(
                                bloc: kwhCubit,
                                listenWhen: (previous, current) {
                                  return previous is! KwhInitial;
                                },
                                listener: (context, stateKwh) {
                                  if (stateKwh is KwhError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Gagal : ${stateKwh.message.toString()}",
                                        ),
                                      ),
                                    );
                                  } else if (stateKwh is KwhSuccessInsert) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Sukses : ${stateKwh.message.toString()}",
                                        ),
                                      ),
                                    );
                                    context.pop();
                                  }
                                },
                                builder: (context, stateKwh) {
                                  if (stateKwh is KwhLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        kwhCubit.simpan(
                                          id_instalasi: state.selectedInstalasi,
                                          tanggal: state.selectedTanggal,
                                          jam: state.selectedJam,
                                          lwbp: lwbp.text.toString(),
                                          wbp: wbp.text.toString(),
                                          kvarh: kvarh.text.toString(),
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
                  //   Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         color: Color.fromRGBO(250, 250, 250, 1),
                  //         borderRadius: BorderRadius.circular(8),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: Colors.black26,
                  //             blurRadius: 4,
                  //             offset: Offset(2, 2),
                  //           ),
                  //         ],
                  //       ),
                  //       padding: EdgeInsets.all(10),
                  //       width: MediaQuery.of(context).size.width,
                  //       child: BlocBuilder<KwhCubit, KwhState>(
                  //         bloc: kwhCubit,
                  //         builder: (context, stateKWH) {
                  //           if (stateKWH is KwhSuccess) {
                  //             return Table(
                  //               columnWidths: const {
                  //                 0: FlexColumnWidth(1),
                  //                 1: FlexColumnWidth(2),
                  //                 2: FlexColumnWidth(2),
                  //                 3: FlexColumnWidth(2),
                  //                 4: FlexColumnWidth(2),
                  //               },
                  //               border: TableBorder.all(
                  //                 width: 1.0,
                  //                 color: Colors.grey,
                  //               ),
                  //               children: [
                  //                 // Table header
                  //                 TableRow(
                  //                   decoration: BoxDecoration(
                  //                     color: Colors.grey[300],
                  //                   ),
                  //                   children: const [
                  //                     Padding(
                  //                       padding: EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         'No',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         'Tanggal',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         'LWBP',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         'WBP',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     Padding(
                  //                       padding: EdgeInsets.all(8.0),
                  //                       child: Text(
                  //                         'KVARH',
                  //                         style: TextStyle(
                  //                           fontWeight: FontWeight.bold,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),

                  //                 // Table rows from stateKWH.data
                  //                 ...stateKWH.data.asMap().entries.map((entry) {
                  //                   final index = entry.key;
                  //                   final data = entry.value;
                  //                   final tanggal =
                  //                       data.waktuLapor?.toIso8601String() ??
                  //                       'Unknown Date';
                  //                   final formattedTanggal =
                  //                       DateTime.tryParse(
                  //                         tanggal,
                  //                       )?.toLocal().toString().split(' ')[0] ??
                  //                       'Invalid Date';

                  //                   return TableRow(
                  //                     children: [
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text((index + 1).toString()),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text(
                  //                           formattedTanggal.toString(),
                  //                         ),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text(data.lwbp.toString()),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text(data.wbp.toString()),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(8.0),
                  //                         child: Text(data.kvarh.toString()),
                  //                       ),
                  //                     ],
                  //                   );
                  //                 }).toList(),
                  //               ],
                  //             );
                  //           } else if (stateKWH is KwhLoading) {
                  //             return Center(child: CircularProgressIndicator());
                  //           } else if (stateKWH is KwhError) {
                  //             return Center(
                  //               child: Text("Error: ${stateKWH.message}"),
                  //             );
                  //           } else {
                  //             return Center(child: Text("Gagal"));
                  //           }
                  //         },
                  //       ),
                  //     ),
                  //   ),
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
