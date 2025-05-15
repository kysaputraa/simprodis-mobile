import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/routes/router.dart';
import 'package:simprodis_flutter/screens/home/bloc_pegawai/pegawai_bloc.dart';
import 'package:simprodis_flutter/widgets/menu_utama.dart';

class BerandaScreen extends StatelessWidget {
  String formatTanggalIndonesia(DateTime date) {
    const List<String> bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${bulan[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    context.read<PegawaiBloc>().add(PegawaiEventFetch());

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img/backgroundlogin.png',
                    ), // Replace with your image path
                    fit: BoxFit.cover,
                  ),
                ),
                height: 150,
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.62, 0.93),
                    end: Alignment(1.30, -0.49),
                    colors: [const Color(0xFFE6E6E6), const Color(0xFFDCF6FA)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 50.0,
                    right: 50.0,
                    top: 50.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: BlocBuilder<PegawaiBloc, PegawaiState>(
                          builder: (context, state) {
                            if (state is PegawaiSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Selamat bertugas, ${state.data.data?.nama}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 81, 135, 1),
                                    ),
                                    softWrap: true,
                                  ),
                                  Text(
                                    formatTanggalIndonesia(DateTime.now()),
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Color.fromRGBO(0, 81, 135, 1),
                                    ),
                                    softWrap: true,
                                  ),
                                  SizedBox(height: 20.0),
                                  Text(
                                    'Username : ${state.data.data?.username}',
                                    style: TextStyle(fontSize: 14.0),
                                    softWrap: true,
                                  ),
                                ],
                              );
                            } else if (state is PegawaiLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is PegawaiError) {
                              return Center(
                                child: Text(
                                  'Error loading data : ${state.message}',
                                ),
                              );
                            }
                            return Center(child: Text('...'));
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/img/user.png',
                              ), // Replace with your image path
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<PegawaiBloc>().add(PegawaiEventFetch());
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Menu_utama(
                                color: Color.fromRGBO(26, 131, 188, 1),
                                title: 'INTAKE',
                                icon: Icons.menu,
                                onTap: () {
                                  context.pushNamed(Routes.intakeScreen);
                                },
                              ),
                              Menu_utama(
                                color: Color.fromRGBO(26, 131, 188, 1),
                                title: 'IPA',
                                icon: Icons.menu,
                                onTap: () {
                                  context.pushNamed(Routes.ipaScreen);
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Menu_utama(
                                color: Color.fromRGBO(26, 131, 188, 1),
                                title: 'Booster Pump',
                                icon: Icons.menu,
                                onTap: () {
                                  context.pushNamed(Routes.boosterScreen);
                                },
                              ),
                              Menu_utama(
                                color: Color.fromRGBO(26, 188, 139, 1),
                                title: 'Laboratorium',
                                icon: Icons.menu,
                                onTap: () {
                                  context.pushNamed(Routes.laboratoriumScreen);
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Menu_utama(
                                color: Colors.red,
                                title: 'Listrik Padam',
                                icon: Icons.menu,
                                onTap: () {
                                  context.pushNamed(Routes.listrikPadamScreen);
                                },
                              ),
                              Menu_utama(
                                color: Color.fromARGB(255, 211, 195, 42),
                                title: 'Pompa OFF',
                                icon: Icons.menu,
                                onTap: () {
                                  context.pushNamed(Routes.pompaPadamScreen);
                                },
                              ),
                            ],
                          ),
                          // Row(
                          //   children: [
                          //     Menu_utama(
                          //       color: Colors.red,
                          //       title: 'Padam Listrik',
                          //       icon: Icons.menu,
                          //       onTap: () {
                          //         context.pushNamed(Routes.listrikPadamScreen);
                          //       },
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Profile image
          Positioned(
            top: 100, // (background container size) - (circle height / 2)
            child: Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                color: Color(0xFFF6FBFF),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/img/logosimprobg.png',
                          ), // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SIMPRO',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                          Text(
                            'SISTEM INFORMASI MONITORING PRODUKSI',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Color.fromRGBO(26, 131, 188, 1),
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
