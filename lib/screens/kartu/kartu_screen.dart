import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/screens/home/bloc_pegawai/pegawai_bloc.dart';
// import 'package:simprodis_flutter/screens/login/bloc/auth_bloc.dart';
import 'package:simprodis_flutter/widgets/loading_widget.dart';

class KartuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Demo());
  }
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // background image and bottom contents
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3,
                color: Colors.blue[100],
                child: const Center(
                  child: FittedBox(
                    child: Text(
                      'KARTU PEGAWAI',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Container(
              //     color: Colors.white,
              //     child: const Center(
              //       child: Text('Content goes here'),
              //     ),
              //   ),
              // )
            ],
          ),
          // Profile image
          Positioned(
            top: 200.0, // (background container size) - (circle height / 2)
            child: Container(
              height: MediaQuery.of(context).size.width * 0.7 * 7 / 4,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: BlocBuilder<PegawaiBloc, PegawaiState>(
                builder: (context, state) {
                  if (state is PegawaiSuccess) {
                    return Stack(
                      children: [
                        Expanded(
                          child: Center(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.width *
                                  0.35 *
                                  7 /
                                  4,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                'https://simpegs.tirtamayang.com/uploads/${state.data.data?.nIK}/fotoprofil/${state.data.data?.nama}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Container(
                              child: Image.asset(
                                'assets/img/depancompressed.png',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 70,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '${state.data.data?.nama}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${state.data.data?.nIK}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is PegawaiLoading) {
                    const LoadingWidget();
                  }
                  return const Center(child: Text('Cannot Fetch User !'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
