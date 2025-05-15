import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/model/instalasi_model.dart';
import 'package:simprodis_flutter/routes/router.dart';

class LaboratoriumScreen extends StatefulWidget {
  LaboratoriumScreen({super.key});

  @override
  State<LaboratoriumScreen> createState() => _LaboratoriumScreenState();
}

class _LaboratoriumScreenState extends State<LaboratoriumScreen> {
  DateTime? _selectedDate;
  String? baseUrl = dotenv.env['BASE_URL'];

  late final InstalasiCubit instalasCubit;

  String? selectedJam;
  String? selectedTanggal;
  String? selectedInstalasi;
  List<String> idPompa = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    instalasCubit = context.read<InstalasiCubit>();
    instalasCubit.fetchData('all');
  }

  final List<String> _jam = List.generate(
    24,
    (index) => (index + 1).toString(),
  );

  // final InstalasiCubit instalasCubit = InstalasiCubit();
  Future<void> _selectDate(BuildContext context) async {
    final instalasCubit = context.read<InstalasiCubit>();
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDateTime != null && pickedDateTime != _selectedDate) {
      final pickedDateString =
          "${pickedDateTime.year}-${pickedDateTime.month.toString().padLeft(2, '0')}-${pickedDateTime.day.toString().padLeft(2, '0')}";
      instalasCubit.selectTanggal(pickedDateString);
    }
  }

  void navigateIfDataExists({
    required BuildContext context,
    required dynamic idInstalasi,
    required dynamic jam,
    required dynamic tanggal,
    required String routeName,
  }) {
    String? error;

    if (idInstalasi == null && routeName != Routes.kualitasAirKonsumenScreen) {
      error = "Silahkan pilih instalasi";
    } else if (tanggal == null) {
      error = "Silahkan pilih tanggal";
    } else if (jam == null) {
      error = "Silahkan pilih tanggal";
    }

    if (error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error)));
      return;
    }

    context.pushNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/img/bgintake.png",
              ), // Replace with your image path
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Uji Kualitas Air Laboratorium",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Add rounded corners
              color: Color.fromRGBO(26, 188, 139, 1),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pilih Instalasi:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 2, // Border width
                          ),
                          borderRadius: BorderRadius.circular(
                            10,
                          ), // Rounded corners
                        ),
                        child: BlocBuilder<InstalasiCubit, InstalasiState>(
                          bloc: instalasCubit,
                          builder: (context, state) {
                            if (state is InstalasiLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (state is InstalasiSuccess) {
                              List<Datum> data = state.data;
                              if (data.isEmpty)
                                return Center(
                                  child: Text(
                                    'Tidak ada instalasi tersedia',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: state.selectedInstalasi,
                                  hint: Text(
                                    'Pilih Instalasi',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onChanged: (String? newValue) {
                                    String selectedInstalasiName =
                                        data
                                            .firstWhere(
                                              (instalasi) =>
                                                  instalasi.idInstalasi ==
                                                  newValue,
                                            )
                                            .namaInstalasi;
                                    log(
                                      'Selected Instalasi Name: $selectedInstalasiName',
                                    );
                                    instalasCubit.selectInstalasi(newValue!);
                                  },
                                  items:
                                      data.map<DropdownMenuItem<String>>((
                                        Datum value,
                                      ) {
                                        return DropdownMenuItem<String>(
                                          value: value.idInstalasi.toString(),
                                          child: Text(value.namaInstalasi),
                                        );
                                      }).toList(),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            } else {
                              return Text('Error loading instalasi');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Add rounded corners
              color: Colors.blue,
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Ink(
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(
                                10,
                              ), // Rounded corners
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: BlocBuilder(
                                    bloc: instalasCubit,
                                    builder: (context, state) {
                                      if (state is InstalasiSuccess &&
                                          state.selectedTanggal != null) {
                                        return Text("${state.selectedTanggal}");
                                      } else {
                                        return Text("Pilih Tanggal");
                                      }
                                    },
                                  ),
                                ),
                                Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // Add rounded corners
              color: Color.fromRGBO(26, 188, 139, 1),
            ),
            height: 60,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: BlocBuilder<InstalasiCubit, InstalasiState>(
                    bloc: instalasCubit,
                    builder: (context, state) {
                      if (state is InstalasiSuccess) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              'Pilih Jam',
                              style: TextStyle(color: Colors.black87),
                            ), // Placeholder text when no item is selected
                            value: state.selectedJam,
                            onChanged: (value) {
                              instalasCubit.selectJam(value!);
                              inspect(value);
                            },
                            items:
                                _jam.map<DropdownMenuItem<String>>((
                                  String value,
                                ) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black87,
                            ), // Icon on the right side
                          ),
                        );
                      } else if (state is InstalasiLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Text("failed to load");
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          BlocBuilder(
            bloc: instalasCubit,
            builder: (context, state) {
              if (state is InstalasiSuccess) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildInkWellButton(
                              context: context,
                              state: state,
                              text: "Uji Kualtias Air Instalasi Harian",
                              routeName: Routes.kualitasAirHarianScreen,
                              color: Colors.blue,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildInkWellButton(
                              context: context,
                              state: state,
                              text: "Uji Kualitas Air Instalasi Lengkap",
                              routeName: Routes.kualitasAirLengkapScreen,
                              color: Colors.blue,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: _buildInkWellButton(
                              context: context,
                              state: state,
                              text: "Uji Kualitas Air Pelanggan",
                              routeName: Routes.kualitasAirKonsumenScreen,
                              color: Colors.blue,
                              textColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (state is InstalasiLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('Gagal'));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInkWellButton({
    required BuildContext context,
    required dynamic state, // Assuming 'state' holds the selected data
    required String text,
    required String routeName,
    required Color color,
    required Color textColor,
    TextAlign? textAlign,
    double? fontSize,
  }) {
    return InkWell(
      onTap: () {
        navigateIfDataExists(
          context: context,
          idInstalasi: state.selectedInstalasi,
          jam: state.selectedJam,
          tanggal: state.selectedTanggal,
          routeName: routeName,
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        height: 100,
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.water_drop, color: textColor, size: 24),
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: textAlign,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize ?? 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
