import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
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

  void _showChangePasswordDialog(BuildContext context, String? username) {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ubah Password'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password Baru'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Konfrimasi Password Baru',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newPassword = newPasswordController.text;
                final confirmPassword = confirmPasswordController.text;

                if (newPassword != confirmPassword) {
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password tidak sama')),
                  );
                  return;
                }

                // Add logic to handle password change here
                String? baseUrl = dotenv.env['BASE_URL'];

                try {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String token = prefs.getString("tokenjwt").toString();
                  Uri url = Uri.parse('${baseUrl}UbahPassword');
                  var response = await http.post(
                    url,
                    headers: {'Authorization': 'Bearer $token'},
                    body: {
                      "username": username,
                      "password": newPasswordController.text,
                    },
                  );

                  var jsonResponse =
                      jsonDecode(response.body) as Map<String, dynamic>;
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                  if (jsonResponse['code'] == 1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Password berhasil diubah')),
                    );
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Gagal !')));
                  }
                } catch (e) {
                  inspect(e);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('Gagal ! ')));
                }
                // Navigator.of(context).pop();
              },
              child: const Text('Ubah'),
            ),
          ],
        );
      },
    );
  }

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
                                    _showChangePasswordDialog(
                                      context,
                                      state.data.data?.username,
                                    );
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
                              ListDetailUser(
                                icon: Icons.work,
                                title: 'Username',
                                value: '${state.data.data?.username}',
                              ),
                              // const Divider(
                              //   endIndent: 10,
                              //   indent: 10,
                              //   height: 5,
                              //   thickness: 2,
                              //   color: Colors.black45,
                              // ),
                              // ListDetailUser(
                              //   icon: Icons.calendar_month,
                              //   title: 'Tempat, Tanggal Lahir',
                              //   value:
                              //       '${state.data.data?.nama}, $formattedDate',
                              // ),
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
                                value: '...',
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
                                value: '...',
                              ),
                              const Divider(
                                endIndent: 10,
                                indent: 10,
                                height: 5,
                                thickness: 2,
                                color: Colors.black45,
                              ),
                              // ListDetailUser(
                              //   icon: Icons.work,
                              //   title: 'Golongan - Pangkat',
                              //   value:
                              //       '${state.data.data?.nama} - ${state.data.data?.nama}',
                              // ),
                              // const Divider(
                              //   endIndent: 10,
                              //   indent: 10,
                              //   height: 5,
                              //   thickness: 2,
                              //   color: Colors.black45,
                              // ),
                              ListDetailUser(
                                icon: Icons.apartment,
                                title: 'Departemen',
                                value: '...',
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
                  // context.pushNamed(Routes.detailScreen);
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
                      context.pushNamed(Routes.loginScreen);
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
