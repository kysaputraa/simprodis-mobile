import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/scada_cubit/scada_cubit.dart';

class ScadaScreen extends StatelessWidget {
  const ScadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController ph_intake = TextEditingController();
    final TextEditingController kekeruhan_intake = TextEditingController();
    final TextEditingController kons_alumn_campuran = TextEditingController();
    final TextEditingController frek_pompa_alumn = TextEditingController();
    final TextEditingController scm = TextEditingController();
    final TextEditingController frek_pompa_chlor = TextEditingController();
    final TextEditingController frek_pompa_kapur = TextEditingController();
    final TextEditingController kekeruhan_sedimentasi = TextEditingController();
    final TextEditingController spey_sedimen = TextEditingController();
    final TextEditingController cuci_filter = TextEditingController();
    final TextEditingController tinggi_reservoir = TextEditingController();
    final TextEditingController ph_resservoir = TextEditingController();
    final TextEditingController sisa_chlor = TextEditingController();

    final scadaCubit = ScadaCubit();

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
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
                    'Pengukuran pH & Sisa Chlor',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 81, 135, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Ph Intake : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: ph_intake,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                                  child: Text("Kekeruhan : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: kekeruhan_intake,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                          Divider(color: Colors.grey, thickness: 1, height: 20),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Konsentrasi koagulan : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: kons_alumn_campuran,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                                  child: Text("Running Pompa Dosing : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: frek_pompa_alumn,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                                  child: Text("SCM : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: scm,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                                  child: Text("Konsentrasi Chlor : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: frek_pompa_chlor,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                                  child: Text("Konsentrasi Kapur : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: frek_pompa_kapur,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                          Divider(color: Colors.grey, thickness: 1, height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Kekeruhan : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: kekeruhan_sedimentasi,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                          Divider(color: Colors.grey, thickness: 1, height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Tinggi (cm) : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: tinggi_reservoir,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                                  child: Text("pH : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: ph_resservoir,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                                  child: Text("Sisa Chlor : "),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: sisa_chlor,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '',
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
                              child: BlocConsumer<ScadaCubit, ScadaState>(
                                bloc: scadaCubit,

                                listener: (context, stateScada) {
                                  if (stateScada is ScadaError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Gagal : ${stateScada.message.toString()}",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (stateScada is ScadaSuccessInsert) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Berhasil : ${stateScada.message.toString()}",
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  }
                                },
                                builder: (context, stateScada) {
                                  if (stateScada is ScadaLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        // scadaCubit.simpan(
                                        //   id_instalasi: state.selectedInstalasi,
                                        //   tanggal: state.selectedTanggal,
                                        //   jam: state.selectedJam,
                                        //   phAirBaku:
                                        //       airBakuController.text.toString(),
                                        //   phAirClarif:
                                        //       clarifController.text.toString(),
                                        //   phAirProduksi:
                                        //       produksiController.text
                                        //           .toString(),
                                        //   phReservoir1:
                                        //       reservoir1Controller.text
                                        //           .toString(),
                                        //   phReservoir2:
                                        //       reservoir2Controller.text
                                        //           .toString(),
                                        // );
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
