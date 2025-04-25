import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/stand_meter_cubit/stand_meter_cubit.dart';

// ignore: must_be_immutable
class StandMeterScreen extends StatelessWidget {
  String? namaKelompok;
  String? idKelompok;
  StandMeterScreen({
    super.key,
    required this.idKelompok,
    required this.namaKelompok,
  });
  List<TextEditingController> standMeterControllers = [];

  @override
  Widget build(BuildContext context) {
    final instalasiCubitState = BlocProvider.of<InstalasiCubit>(context).state;
    final standMeterCubit = StandMeterCubit();
    standMeterCubit.fetchData(idKelompokStandMeter: idKelompok);
    String? selectedJam;
    String? selectedTanggal;
    List<String> idStandMeter = [];

    if (instalasiCubitState is InstalasiSuccess) {
      selectedJam = instalasiCubitState.selectedJam;
      selectedTanggal = instalasiCubitState.selectedTanggal;
    }
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
                  'Stand Meter Air',
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
                          SizedBox(height: 15),
                          Text(
                            "Kelompok Meter Induk",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 81, 135, 1),
                            ),
                          ),
                          Text(
                            '$namaKelompok',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocConsumer<StandMeterCubit, StandMeterState>(
                    bloc: standMeterCubit,
                    listener: (context, state) {
                      if (state is StandMeterSuccessInsert) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data berhasil disimpan!')),
                        );
                        Navigator.of(context).pop();
                      } else if (state is StandMeterError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal : ${state.message}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is StandMeterSuccess) {
                        for (int i = 0; i < state.data.length; i++) {
                          standMeterControllers.add(TextEditingController());
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            final pressure = state.data[index];
                            idStandMeter.add(pressure.idMeter!);
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
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
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text("Nama"),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                color: Color.fromRGBO(
                                                  26,
                                                  188,
                                                  139,
                                                  1,
                                                ),
                                                child: Text(
                                                  "${state.data[index].namaMeter}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Text("Keterangan"),
                                            ),
                                            Expanded(
                                              flex: 6,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                color: Color.fromRGBO(
                                                  26,
                                                  188,
                                                  139,
                                                  0.51,
                                                ),
                                                child: Text(
                                                  "${state.data[index].spesifikasi}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text("Stand Meter Air "),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: TextFormField(
                                            controller:
                                                standMeterControllers[index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'stand meter air',
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                            );
                          },
                        );
                      } else if (state is StandMeterLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is StandMeterError) {
                        return Center(child: Text("Error: ${state.message}"));
                      } else {
                        return Center(child: Text("Gagal"));
                      }
                    },
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(26, 131, 188, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.save, color: Colors.white),
                    onPressed: () {
                      List<String> standMeterList =
                          standMeterControllers
                              .map((controller) => controller.text)
                              .toList();

                      standMeterCubit.simpan(
                        idKelompokStandMeter: idKelompok,
                        idStandMeter: idStandMeter,
                        standMeterList: standMeterList,
                        jam: selectedJam,
                        tanggal: selectedTanggal,
                      );
                    },
                    label: Text(
                      "SIMPAN",
                      style: TextStyle(color: Colors.white),
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
