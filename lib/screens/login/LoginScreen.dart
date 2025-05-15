import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/routes/router.dart';
import 'package:simprodis_flutter/screens/home/bloc_pegawai/pegawai_bloc.dart';
import 'package:simprodis_flutter/screens/login/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String svg = '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="#0099ff" fill-opacity="1" d="M0,320L34.3,320C68.6,320,137,320,206,304C274.3,288,343,256,411,256C480,256,549,288,617,272C685.7,256,754,192,823,186.7C891.4,181,960,235,1029,213.3C1097.1,192,1166,96,1234,58.7C1302.9,21,1371,43,1406,53.3L1440,64L1440,320L1405.7,320C1371.4,320,1303,320,1234,320C1165.7,320,1097,320,1029,320C960,320,891,320,823,320C754.3,320,686,320,617,320C548.6,320,480,320,411,320C342.9,320,274,320,206,320C137.1,320,69,320,34,320L0,320Z"></path></svg>
''';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController username = TextEditingController();

  final TextEditingController password = TextEditingController();

  final AuthBloc authBloc = AuthBloc();

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Color.fromRGBO(
          213,
          235,
          250,
          1,
        ), // Replace with your desired hex color
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // SvgPicture.asset(
            //   'assets/svg/backgroundLogin.svg',
            //   alignment: Alignment.center,
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   fit: BoxFit.fill,
            // ),
            // Container(
            //   color: Colors.yellow,
            //   width: MediaQuery.of(context).size.width,
            //   height: MediaQuery.of(context).size.height,
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: SvgPicture.string(
            //       svg,
            //       width: MediaQuery.of(context).size.width,
            //       height: 70,
            //     ),
            //   ),
            // ),
            Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/img/backgroundlogin.png',
                    width: screenWidth,
                    height: MediaQuery.of(context).size.height / 2,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Image.asset('assets/img/tirtamayang.png', width: 120),
                        SizedBox(height: 40),
                        Image.asset('assets/img/logosimpro.png', width: 100),
                        Text(
                          'SIMPRO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.17,
                          ),
                        ),
                        Text(
                          'SISTEM INFORMASI MONITORING PRODUKSI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.62,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Log In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -50),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   'assets/img/MyOwnVocab.png',
                    //   width: 300,
                    //   height: 150,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(
                                  0,
                                  3,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          width: double.infinity,
                          height: 231,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: username,
                                  decoration: InputDecoration(
                                    labelText: 'Username',
                                    hintText: 'Enter your username',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: const Color(0xFF1871AD),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: const Color(0xFF1871AD),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: password,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: const Color(0xFF1871AD),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: const Color(0xFF1871AD),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocConsumer<AuthBloc, AuthState>(
                                  bloc: authBloc,
                                  listener: (context, state) {
                                    if (state is AuthSuccess) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "SUCCESS : ${state.message}",
                                          ),
                                        ),
                                      );
                                      context.read<PegawaiBloc>().add(
                                        PegawaiEventFetch(),
                                      );

                                      context.pushNamed(Routes.bottomNavbar);
                                    } else if (state is AuthError) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "FAILED : ${state.message}",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AuthLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFF1871AD,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        minimumSize: const Size.fromHeight(50),
                                      ),
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        authBloc.add(
                                          AuthEventLogin(
                                            username: username.text,
                                            password: password.text,
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Log In',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(33, 122, 182, 0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.elliptical(
                              MediaQuery.of(context).size.width / 2,
                              MediaQuery.of(context).size.width / 4,
                            ),
                            topRight: Radius.elliptical(
                              MediaQuery.of(context).size.width / 2,
                              MediaQuery.of(context).size.width / 4,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'DEPARTEMEN TEKNOLOGI INFORMASI - DEPARTEMEN PRODUKSI ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF005086),
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1.73,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'PERUMDAM TIRTA MAYANG KOTA JAMBI ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF005086),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.67,
                            ),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
