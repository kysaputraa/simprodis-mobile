import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/pompa_cubit/cubit/pompa_cubit.dart';

class PompaScreen extends StatelessWidget {
  String? namaKelompok;
  String? idKelompok;
  PompaScreen({
    super.key,
    required this.idKelompok,
    required this.namaKelompok,
  });

  List<TextEditingController> amphereControllers = [];
  List<TextEditingController> speedControllers = [];
  List<TextEditingController> pressureControllers = [];

  @override
  Widget build(BuildContext context) {
    final instalasiCubitState = BlocProvider.of<InstalasiCubit>(context).state;
    final pompaCubit = PompaCubit();
    pompaCubit.fetchData(idKelompokPompa: idKelompok);
    String? selectedJam;
    String? selectedTanggal;
    String? selectedInstalasi;
    List<String> idPompa = [];

    if (instalasiCubitState is InstalasiSuccess) {
      selectedJam = instalasiCubitState.selectedJam;
      selectedTanggal = instalasiCubitState.selectedTanggal;
      selectedInstalasi = instalasiCubitState.selectedInstalasi;
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
                  'Pompa',
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
                            "Kelompok Pompa",
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
                  BlocConsumer<PompaCubit, PompaState>(
                    bloc: pompaCubit,
                    listener: (context, state) {
                      if (state is PompaSuccessInsert) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data berhasil disimpan!')),
                        );
                        Navigator.of(context).pop();
                      } else if (state is PompaError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal : ${state.message}')),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is PompaSuccess) {
                        for (int i = 0; i < state.data.length; i++) {
                          amphereControllers.add(TextEditingController());
                          speedControllers.add(TextEditingController());
                          pressureControllers.add(TextEditingController());
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            final pompa = state.data[index];
                            idPompa.add(pompa.idPompa);
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
                                              child: Text("Nama Pompa"),
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
                                                  "${state.data[index].namaPompa}",
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
                                                  "${state.data[index].keterangan}",
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
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("Amphere : "),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextFormField(
                                            controller:
                                                amphereControllers[index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Amphere',
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
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text("Speed (hz) : "),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextFormField(
                                            controller: speedControllers[index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Speed',
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
                                            controller:
                                                pressureControllers[index],
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'Pressure (atm)',
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
                      } else if (state is PompaLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PompaError) {
                        return Center(child: Text("Error: ${state.message}"));
                      } else {
                        return Center(child: Text("Gagal"));
                      }
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      List<String> amphereList =
                          amphereControllers
                              .map((controller) => controller.text)
                              .toList();
                      List<String> speedList =
                          speedControllers
                              .map((controller) => controller.text)
                              .toList();
                      List<String> pressureList =
                          pressureControllers
                              .map((controller) => controller.text)
                              .toList();

                      pompaCubit.simpan(
                        amphereList: amphereList,
                        idKelompokPompa: idKelompok,
                        pressureList: pressureList,
                        speedList: speedList,
                        jam: selectedJam,
                        tanggal: selectedTanggal,
                        idPompa: idPompa,
                      );
                    },
                    child: Text("SIMPAN"),
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
