import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/routes/router.dart';
import 'package:simprodis_flutter/screens/home/bloc_pegawai/pegawai_bloc.dart';
import 'package:simprodis_flutter/screens/login/bloc/auth_bloc.dart';
import 'package:simprodis_flutter/widgets/list_detail_user.dart';
import 'package:intl/intl.dart';

class UserSettings extends StatelessWidget {
  const UserSettings({super.key});
  // Method to fetch SharedPreferences data

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<PegawaiBloc, PegawaiState>(
              builder: (context, state) {
                if (state is PegawaiSuccess) {
                  // DateFormat inputFormat =
                  //     DateFormat('yyyy-MM-dd'); // Adjust the format as needed
                  // DateTime dateTime =
                  //     inputFormat.parse('${state.data.data?.tglLahir}');

                  DateTime dateTime = DateTime.now(); // Replace with your date
                  String formattedDate = DateFormat(
                    'yyyy-MM-dd',
                  ).format(dateTime);

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,

                                color:
                                    Colors.blue[300], // Circle background color
                              ),
                            ),
                            CircleAvatar(
                              radius: 80,

                              backgroundImage: NetworkImage(
                                'https://simpegs.tirtamayang.com/uploads/${state.data.data?.nIK}/fotoprofil/${state.data.data?.nama}',
                              ), // Replace with your image URL
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                        0,
                                        3,
                                      ), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // Handle edit button press
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Transform.translate(
                          offset: Offset(0, -20), // Negative vertical shift
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(
                                    0,
                                    3,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            height: 75,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${state.data.data?.nama}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${state.data.data?.nIK}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // const SizedBox(height: 20),
                        Card(
                          elevation: 3,
                          color: Colors.white,
                          child: Column(
                            children: [
                              // ListDetailUser(
                              //     icon: Icons.person,
                              //     title: 'NIK | Nama',
                              //     value:
                              //         '${state.data.data?.nIK} | ${state.data.data?.nama}'),
                              // const Divider(
                              //   endIndent: 10,
                              //   indent: 10,
                              //   height: 5,
                              //   thickness: 2,
                              //   color: Colors.black45,
                              // ),
                              ListDetailUser(
                                icon: Icons.calendar_month,
                                title: 'Tempat, Tanggal Lahir',
                                value:
                                    '${state.data.data?.nama}, $formattedDate',
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                                height: 5,
                                thickness: 2,
                                color: Colors.black45,
                              ),
                              ListDetailUser(
                                icon: Icons.star,
                                title: 'Agama',
                                value: '${state.data.data?.nama}',
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                                height: 5,
                                thickness: 2,
                                color: Colors.black45,
                              ),
                              ListDetailUser(
                                icon: Icons.home,
                                title: 'Alamat',
                                value: '${state.data.data?.nama}',
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                                height: 5,
                                thickness: 2,
                                color: Colors.black45,
                              ),
                              ListDetailUser(
                                icon: Icons.work,
                                title: 'Jabatan',
                                value: '${state.data.data?.nama}',
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                                height: 5,
                                thickness: 2,
                                color: Colors.black45,
                              ),
                              ListDetailUser(
                                icon: Icons.work,
                                title: 'Golongan - Pangkat',
                                value:
                                    '${state.data.data?.nama} - ${state.data.data?.nama}',
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                                height: 5,
                                thickness: 2,
                                color: Colors.black45,
                              ),
                              ListDetailUser(
                                icon: Icons.apartment,
                                title: 'Departemen',
                                value: '${state.data.data?.nama}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 150,
                    child: Text("failed to fetch"),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 5,
              ),
              child: ElevatedButton(
                onPressed: () {
                  authBloc.add(AuthEventLogout());
                  // context.goNamed(Routes.detailScreen);
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Color.fromARGB(255, 36, 25, 152),
                  foregroundColor: Colors.white,
                ),
                child: BlocConsumer<AuthBloc, AuthState>(
                  bloc: authBloc,
                  listener: (context, state) {
                    if (state is AuthLogout) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("berhasil Logout !")),
                      );
                      context.goNamed(Routes.loginScreen);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Text('LOADING');
                    }
                    return const Text('Logout', style: TextStyle(fontSize: 17));
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
