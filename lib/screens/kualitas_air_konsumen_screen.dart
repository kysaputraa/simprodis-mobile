import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simprodis_flutter/bloc/air_konsumen_cubit/air_konsumen_cubit.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/bloc/pelanggan_cubit/pelanggan_cubit.dart';
import 'package:simprodis_flutter/widgets/loading_entire_screen.dart';

class KualitasAirKonsumenScreen extends StatefulWidget {
  KualitasAirKonsumenScreen({super.key});

  @override
  State<KualitasAirKonsumenScreen> createState() =>
      _KualitasAirKonsumenScreenState();
}

class _KualitasAirKonsumenScreenState extends State<KualitasAirKonsumenScreen> {
  final PelangganCubit pelangganCubit = PelangganCubit();
  bool dataPelanggan = false;
  late GoogleMapController _mapController;
  final LatLng point = LatLng(37.7749, -122.4194); // Example: San Francisco
  String? namaPelanggan;
  String? alamatPelanggan;
  String? latPelanggan;
  String? longPelanggan;
  String? zona;
  String? gol;
  String? kdCabang;
  String? kdKelurahan;
  String? kdKecamatan;
  final TextEditingController nopam = TextEditingController();
  final TextEditingController ph = TextEditingController();
  final TextEditingController kekeruhan = TextEditingController();
  final TextEditingController sisaChlor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final airKonsumenCubit = AirKonsumenCubit();
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
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Uji Kualitas Air Instalasi Harian Konsumen',
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
          if (state is InstalasiSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Color.fromRGBO(242, 240, 240, 1),
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
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(
                  //           "Instalasi",
                  //           style: TextStyle(
                  //             color: Color.fromRGBO(0, 81, 135, 1),
                  //           ),
                  //         ),
                  //         BlocBuilder<InstalasiCubit, InstalasiState>(
                  //           builder: (context, state) {
                  //             if (state is InstalasiSuccess) {
                  //               return Text(
                  //                 '',
                  //                 style: TextStyle(
                  //                   color: Color.fromRGBO(0, 81, 135, 1),
                  //                   fontSize: 24,
                  //                   fontWeight: FontWeight.bold,
                  //                 ),
                  //               );
                  //             }
                  //             return Text("Failed to load !");
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Data Pelanggan",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 81, 135, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Nomor PAM : "),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  onFieldSubmitted: (value) {
                                    log(value);
                                    pelangganCubit.fetchData(nopam: value);
                                  },
                                  controller: nopam,
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
                          BlocConsumer<PelangganCubit, PelangganState>(
                            listener: (context, statePelanggan) {
                              if (statePelanggan is PelangganLoading) {
                                showLoadingEntireScreen(context, status: true);
                              } else {
                                showLoadingEntireScreen(context, status: false);
                              }
                              if (statePelanggan is PelangganSuccess &&
                                  statePelanggan.dataPelanggan?.nama == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Data Tidak Ditemukan"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } else if (statePelanggan is PelangganSuccess &&
                                  statePelanggan.dataPelanggan?.nama != null) {
                                setState(() {
                                  dataPelanggan = true;
                                  namaPelanggan =
                                      statePelanggan.dataPelanggan?.nama;
                                  alamatPelanggan =
                                      statePelanggan.dataPelanggan?.alamat;
                                  latPelanggan =
                                      statePelanggan.dataPelanggan?.lat;
                                  longPelanggan =
                                      statePelanggan.dataPelanggan?.lng;
                                  zona = statePelanggan.dataPelanggan?.zona;
                                  gol = statePelanggan.dataPelanggan?.gol;
                                  kdCabang =
                                      statePelanggan.dataPelanggan?.kdCabang;
                                  kdKelurahan =
                                      statePelanggan.dataPelanggan?.kdKelurahan;
                                  kdKecamatan =
                                      statePelanggan.dataPelanggan?.kdKecamatan;
                                });
                              }
                            },
                            bloc: pelangganCubit,
                            builder: (context, statePelanggan) {
                              if (statePelanggan is PelangganSuccess &&
                                  statePelanggan.dataPelanggan?.nama != null) {
                                LatLng latLngPelanggan = LatLng(
                                  double.tryParse(
                                        statePelanggan.dataPelanggan?.lat ?? '',
                                      ) ??
                                      37.7749,
                                  double.tryParse(
                                        statePelanggan.dataPelanggan?.lng ?? '',
                                      ) ??
                                      -122.4194,
                                );

                                inspect(latLngPelanggan);
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${statePelanggan.dataPelanggan?.nama}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "${statePelanggan.dataPelanggan?.alamat}",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Status Pelanggan : ${statePelanggan.dataPelanggan?.kdStatus}",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                Text(
                                                  "Zona : ${statePelanggan.dataPelanggan?.zona}",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                                Text(
                                                  "Gol : ${statePelanggan.dataPelanggan?.gol}     Wilayah : ${statePelanggan.dataPelanggan?.kdCabang}",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Expanded(
                                          //   child: Image.network(
                                          //     Uri.encodeFull(
                                          //       // "https://data.tirtamayang.com/persil/1603001 PUSKESMAS.JPG",
                                          //       "https://data.tirtamayang.com/persil/${statePelanggan.dataPelanggan?.foto}",
                                          //     ),
                                          //     width: double.infinity,
                                          //     fit: BoxFit.cover,
                                          //     errorBuilder: (
                                          //       context,
                                          //       error,
                                          //       stackTrace,
                                          //     ) {
                                          //       return Center(
                                          //         child: Text(
                                          //           'Image failed to load',
                                          //         ),
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 200,
                                        child: GoogleMap(
                                          initialCameraPosition: CameraPosition(
                                            target: latLngPelanggan,
                                            zoom: 14,
                                          ),
                                          markers: {
                                            Marker(
                                              markerId: MarkerId('my-marker'),
                                              position: latLngPelanggan,
                                              infoWindow: InfoWindow(
                                                title: 'My Location',
                                              ),
                                            ),
                                          },
                                          onMapCreated: (controller) {
                                            _mapController = controller;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Data",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 81, 135, 1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("pH : "),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: ph,
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
                                flex: 1,
                                child: TextFormField(
                                  controller: kekeruhan,
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
                                flex: 1,
                                child: TextFormField(
                                  controller: sisaChlor,
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
                              child: BlocConsumer<
                                AirKonsumenCubit,
                                AirKonsumenState
                              >(
                                bloc: airKonsumenCubit,

                                listener: (context, stateAirKonsumen) {
                                  if (stateAirKonsumen is AirKonsumenError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Gagal : ${stateAirKonsumen.message.toString()}",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (stateAirKonsumen
                                      is AirKonsumenSuccessInsert) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Berhasil : ${stateAirKonsumen.message.toString()}",
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  }
                                },
                                builder: (context, stateAirKonsumen) {
                                  if (stateAirKonsumen is AirKonsumenLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        if (dataPelanggan) {
                                          airKonsumenCubit.simpan(
                                            id_instalasi:
                                                state.selectedInstalasi,
                                            tanggal: state.selectedTanggal,
                                            jam: state.selectedJam,
                                            nopam: nopam.text,
                                            ph: ph.text,
                                            kekeruhan: kekeruhan.text,
                                            sisaChlor: sisaChlor.text,
                                            namaPelanggan: namaPelanggan,
                                            alamatPelanggan: alamatPelanggan,
                                            latPelanggan: latPelanggan,
                                            longPelanggan: longPelanggan,
                                            zona: zona,
                                            gol: gol,
                                            kdCabang: kdCabang,
                                            kdKelurahan: kdKelurahan,
                                            kdKecamatan: kdKecamatan,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Harap Cari Pelanggan terlebih dahulu",
                                              ),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
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
