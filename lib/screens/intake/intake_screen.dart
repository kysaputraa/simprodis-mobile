import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/model/instalasi_model.dart';
import 'package:simprodis_flutter/routes/router.dart';
import 'package:simprodis_flutter/screens/intake/bloc/intake_bloc.dart';

class IntakeScreen extends StatefulWidget {
  IntakeScreen({super.key});

  @override
  State<IntakeScreen> createState() => _IntakeScreenState();
}

class _IntakeScreenState extends State<IntakeScreen> {
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
    instalasCubit.fetchData('intake');
  }

  final IntakeBloc authBloc = IntakeBloc();

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

  void _selectDateTime(BuildContext context) async {
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
                  "INTAKE",
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
                              if (data.isEmpty) {
                                return Center(
                                  child: Text(
                                    'Tidak ada instalasi tersedia',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }

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
          BlocBuilder(
            bloc: instalasCubit,
            builder: (context, state) {
              if (state is InstalasiSuccess) {
                return Column(
                  children: [
                    SizedBox(height: 10.0),
                    Center(
                      child: InkWell(
                        onTap: () {
                          // context.pushNamed(Routes.kwhScreen);
                          navigateIfDataExists(
                            context: context,
                            idInstalasi: state.selectedInstalasi,
                            jam: state.selectedJam,
                            tanggal: state.selectedTanggal,
                            routeName: Routes.kwhScreen,
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Rounded corners
                            color: Colors.blue,
                          ),
                          height: 50,
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Center(
                            child: Text(
                              "kWh Listrik",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: InkWell(
                        onTap: () {
                          navigateIfDataExists(
                            context: context,
                            idInstalasi: state.selectedInstalasi,
                            jam: state.selectedJam,
                            tanggal: state.selectedTanggal,
                            routeName: Routes.tinggiSungaiScreen,
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Rounded corners
                            color: Color.fromRGBO(87, 230, 175, 1),
                          ),
                          height: 50,
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Center(
                            child: Text(
                              "Tinggi Sungai",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: InkWell(
                        onTap: () {
                          navigateIfDataExists(
                            context: context,
                            idInstalasi: state.selectedInstalasi,
                            jam: state.selectedJam,
                            tanggal: state.selectedTanggal,
                            routeName: Routes.voltageScreen,
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Rounded corners
                            color: Color.fromRGBO(87, 230, 175, 1),
                          ),
                          height: 50,
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Center(
                            child: Text(
                              "Voltage",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: InkWell(
                        onTap: () {
                          navigateIfDataExists(
                            context: context,
                            idInstalasi: state.selectedInstalasi,
                            jam: state.selectedJam,
                            tanggal: state.selectedTanggal,
                            routeName: Routes.pressureScreen2,
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Rounded corners
                            color: Color.fromRGBO(87, 230, 175, 1),
                          ),
                          height: 50,
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Center(
                            child: Text(
                              "Pressure Gab",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: InkWell(
                        onTap: () {
                          navigateIfDataExists(
                            context: context,
                            idInstalasi: state.selectedInstalasi,
                            jam: state.selectedJam,
                            tanggal: state.selectedTanggal,
                            routeName: Routes.kelompokPompaScreen,
                          );
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ), // Rounded corners
                            color: Color.fromRGBO(87, 230, 175, 1),
                          ),
                          height: 50,
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Center(
                            child: Text(
                              "Pompa",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is InstalasiLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(child: Text('...'));
              }
            },
          ),
        ],
      ),
    );
  }
}
