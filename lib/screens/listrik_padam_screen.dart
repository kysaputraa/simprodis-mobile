import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/listrik_padam_cubit/listrik_padam_cubit.dart';
import 'package:simprodis_flutter/model/instalasi_model.dart';

class ListrikPadamScreen extends StatefulWidget {
  ListrikPadamScreen({super.key});

  @override
  State<ListrikPadamScreen> createState() => _ListrikPadamScreenState();
}

class _ListrikPadamScreenState extends State<ListrikPadamScreen> {
  DateTime? _selectedDate;
  String? baseUrl = dotenv.env['BASE_URL'];

  late final InstalasiCubit instalasCubit;
  late final ListrikPadamCubit listrikPadamCubit = ListrikPadamCubit();

  String? selectedJam;
  String? selectedTanggal;
  String? selectedInstalasi;
  List<String> idPompa = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    instalasCubit = context.read<InstalasiCubit>();
    instalasCubit.fetchData("all");
  }

  // Future<List<Datum>> fetchInstalasi() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   String token = prefs.getString("tokenjwt").toString();
  //   String username = prefs.getString("username").toString();

  //   Uri url = Uri.parse('${baseUrl}getIntalasiByUser');
  //   var response = await http.post(
  //     url,
  //     headers: {'Authorization': 'Bearer $token'},
  //     body: {"username": username},
  //   );
  //   var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
  //   InstalasiModel data = InstalasiModel.fromJson(jsonResponse);
  //   if (data.code == 1 || response.statusCode == 200) {
  //     List<Datum> instalasiList = data.data ?? [];
  //     log("instalasiList");
  //     return instalasiList;
  //   } else {
  //     // return instalasiList;
  //     throw Exception('Failed to load instalasi');
  //   }
  // }

  // final InstalasiCubit instalasCubit = InstalasiCubit();
  // Future<void> _selectDate(BuildContext context) async {
  //   final instalasCubit = context.read<InstalasiCubit>();
  //   final DateTime? pickedDateTime = await showDatePicker(
  //     context: context,
  //     initialDate: _selectedDate ?? DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );
  //   if (pickedDateTime != null && pickedDateTime != _selectedDate) {
  //     final pickedDateString =
  //         "${pickedDateTime.year}-${pickedDateTime.month.toString().padLeft(2, '0')}-${pickedDateTime.day.toString().padLeft(2, '0')}";
  //     instalasCubit.selectTanggal(pickedDateString);
  //   }
  // }

  void _selectDateTime(
    BuildContext context,
    void Function(String) onDateTimeSelected,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate ?? DateTime.now()),
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        final formattedDateTime =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} ${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
        log("Selected DateTime: $formattedDateTime");
        onDateTimeSelected(formattedDateTime);
      }
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

    if (idInstalasi == null) {
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
                  "Listrik Padam",
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
                                    listrikPadamCubit.fetchData(
                                      idInstalasi: newValue,
                                    );
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
                            } else if (state is InstalasiError) {
                              return Text('Error: ${state.message}');
                            } else {
                              return Text('Unknown state');
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

          BlocBuilder(
            bloc: instalasCubit,
            builder: (context, state) {
              if (state is InstalasiSuccess) {
                return BlocConsumer<ListrikPadamCubit, ListrikPadamState>(
                  bloc: listrikPadamCubit,
                  listener: (context, stateListrikPadam) {
                    if (stateListrikPadam is ListrikPadamSuccessInsert) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(stateListrikPadam.message),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else if (stateListrikPadam is ListrikPadamError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(stateListrikPadam.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, stateListrikPadam) {
                    if (stateListrikPadam is ListrikPadamLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (stateListrikPadam is ListrikPadamError) {
                      return Center(
                        child: Text('Gagal : ${stateListrikPadam.message}'),
                      );
                    } else if (stateListrikPadam is ListrikPadamSuccess) {
                      return Column(
                        children: [
                          const SizedBox(height: 10.0),
                          Container(
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Listrik Padam (Off)",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                      ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (stateListrikPadam
                                                              .data
                                                              ?.waktuPadam ==
                                                          null) {
                                                        _selectDateTime(
                                                          context,
                                                          listrikPadamCubit
                                                              .selectWaktuPadam,
                                                        );
                                                      }
                                                    },
                                                    child: Ink(
                                                      child: Container(
                                                        height: 40,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ), // Rounded corners
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .centerLeft,
                                                              child: BlocBuilder(
                                                                bloc:
                                                                    instalasCubit,
                                                                builder: (
                                                                  context,
                                                                  state,
                                                                ) {
                                                                  if (stateListrikPadam
                                                                          .data
                                                                          ?.waktuPadam !=
                                                                      null) {
                                                                    return Text(
                                                                      "${stateListrikPadam.data?.waktuPadam}",
                                                                    );
                                                                  } else if (stateListrikPadam
                                                                          .selectedWaktuPadam !=
                                                                      null) {
                                                                    return Text(
                                                                      "${stateListrikPadam.selectedWaktuPadam}",
                                                                    );
                                                                  } else {
                                                                    return Text(
                                                                      "Pilih Tanggal",
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .calendar_month_rounded,
                                                              color:
                                                                  Colors.black,
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
                                      ],
                                    ),
                                  ),
                                ),
                                if (stateListrikPadam.data?.waktuPadam != null)
                                  Expanded(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color:
                                            Colors
                                                .grey, // Changed from Colors.red to a disabled color (grey)
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Off",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.6,
                                            ), // Make text color lighter (semi-transparent)
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (stateListrikPadam.data?.waktuPadam == null)
                                  Expanded(
                                    child: Center(
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {
                                            if (stateListrikPadam
                                                    .selectedWaktuPadam !=
                                                null) {
                                              listrikPadamCubit.simpan(
                                                id_instalasi:
                                                    state.selectedInstalasi,
                                                waktuPadam:
                                                    stateListrikPadam
                                                        .selectedWaktuPadam,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Silahkan pilih waktu padam terlebih dahulu",
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                  offset: Offset(2, 2),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Off",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
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
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "Listrik Hidup Kembali (On)",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                      ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      _selectDateTime(
                                                        context,
                                                        listrikPadamCubit
                                                            .selectWaktuHidup,
                                                      );
                                                    },
                                                    child: Ink(
                                                      child: Container(
                                                        height: 40,
                                                        padding:
                                                            EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ), // Rounded corners
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .centerLeft,
                                                              child: BlocBuilder(
                                                                bloc:
                                                                    instalasCubit,
                                                                builder: (
                                                                  context,
                                                                  state,
                                                                ) {
                                                                  if (stateListrikPadam
                                                                          .selectedWaktuHidup !=
                                                                      null) {
                                                                    return Text(
                                                                      "${stateListrikPadam.selectedWaktuHidup}",
                                                                    );
                                                                  } else {
                                                                    return Text(
                                                                      "Pilih Tanggal",
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .calendar_month_rounded,
                                                              color:
                                                                  Colors.black,
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
                                      ],
                                    ),
                                  ),
                                ),
                                if (stateListrikPadam.data?.waktuPadam == null)
                                  Expanded(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color:
                                            Colors
                                                .grey, // Changed from Colors.red to a disabled color (grey)
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "ON",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(
                                              0.6,
                                            ), // Make text color lighter (semi-transparent)
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (stateListrikPadam.data?.waktuPadam != null)
                                  Expanded(
                                    child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          if (stateListrikPadam
                                                      .selectedWaktuHidup !=
                                                  null &&
                                              stateListrikPadam.data?.id !=
                                                  null) {
                                            listrikPadamCubit.updateWaktuHidup(
                                              idInstalasi:
                                                  state.selectedInstalasi,
                                              id_padam:
                                                  stateListrikPadam.data?.id,
                                              waktu_hidup_kembali:
                                                  stateListrikPadam
                                                      .selectedWaktuHidup,
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Silahkan pilih waktu hidup kembali",
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        child: Ink(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 4,
                                                  offset: Offset(2, 2),
                                                ),
                                              ],
                                            ),

                                            child: Center(
                                              child: Text(
                                                "ON",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(child: Text('Silahkan pilih instalasi'));
                    }
                  },
                );
              } else if (state is InstalasiLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('Gagal Instalasi'));
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
        height: 50,
        padding: const EdgeInsets.all(8.0),
        child: Center(
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
      ),
    );
  }
}
