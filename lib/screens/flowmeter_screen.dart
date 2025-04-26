import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/bloc/flowmeter_cubit/flowmeter_cubit.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';

class FlowmeterScreen extends StatefulWidget {
  const FlowmeterScreen({super.key});

  @override
  State<FlowmeterScreen> createState() => FlowmeterScreenState();
}

class FlowmeterScreenState extends State<FlowmeterScreen> {
  String? selectedFlowMeter;
  final TextEditingController debitController = TextEditingController();
  final TextEditingController standMeterController = TextEditingController();

  Widget build(BuildContext context) {
    final flowmeterCubit = FlowmeterCubit();
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
                  'Flow Meter',
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
            flowmeterCubit.fetchData(idInstalasi: state.selectedInstalasi);
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
                        bloc: flowmeterCubit,
                        builder: (FlowmeterCubit, FlowmeterState) {
                          if (FlowmeterState is FlowmeterSuccess) {
                            if (FlowmeterState.data.isEmpty) {
                              return Center(
                                child: Text(
                                  'Tidak ada instalasi tersedia',
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            return DropdownButtonFormField<String>(
                              value: selectedFlowMeter,
                              isExpanded: true,
                              decoration: InputDecoration(
                                labelText: 'Pilih Kelompok Flowmeter',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              items:
                                  FlowmeterState.data.map<
                                    DropdownMenuItem<String>
                                  >((item) {
                                    return DropdownMenuItem<String>(
                                      value:
                                          item.idFlowmeter, // Adjust the key based on your data structure
                                      child: Text(
                                        item.namaFlowmeter
                                            .toString(), // Adjust the key based on your data structure
                                      ), // Adjust the key based on your data structure
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  log(value.toString());
                                  selectedFlowMeter = value;
                                });
                              },
                            );
                          } else if (FlowmeterState is FlowmeterLoading) {
                            return Center(
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (FlowmeterState is FlowmeterError) {
                            return Center(
                              child: Text("Gagal: ${FlowmeterState.message}"),
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
                                  alignment: Alignment.centerLeft,
                                  child: Text("Debit (l/d): "),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: debitController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Debit (l/d)',
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
                                  alignment: Alignment.centerLeft,
                                  child: Text("Stand Meter (m3): "),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: standMeterController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Stand Meter (m3)',
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
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: BlocConsumer<FlowmeterCubit, FlowmeterState>(
                        bloc: flowmeterCubit,
                        listener: (context, stateFlowmeter) {
                          if (stateFlowmeter is FlowmeterSuccessInsert) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Data berhasil disimpan"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.of(context).pop();
                          } else if (stateFlowmeter is FlowmeterError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Gagal menyimpan data"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, stateFlowmeter) {
                          if (stateFlowmeter is FlowmeterLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ElevatedButton.icon(
                              onPressed: () {
                                if (selectedFlowMeter != null &&
                                    standMeterController.text.isNotEmpty &&
                                    debitController.text.isNotEmpty) {
                                  flowmeterCubit.simpan(
                                    tanggal: state.selectedTanggal,
                                    jam: state.selectedJam,
                                    idFlowmeter: selectedFlowMeter,
                                    debit: debitController.text,
                                    standMeter: standMeterController.text,
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
