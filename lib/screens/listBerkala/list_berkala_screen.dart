import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/model/berkala_model.dart';
import 'package:simprodis_flutter/routes/router.dart';
import 'package:simprodis_flutter/screens/listBerkala/bloc/berkala_bloc.dart';
import 'package:simprodis_flutter/widgets/circle_number.dart';

class ListBerkala extends StatelessWidget {
  ListBerkala({super.key});

  final BerkalaBloc berkalaBloc = BerkalaBloc();

  @override
  Widget build(BuildContext context) {
    berkalaBloc.add(BerkalaEventFetch());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Riwayat Berkala Saya',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer(
        bloc: berkalaBloc,
        listener: (context, state) {
          if (state is BerkalaSucces) {
            List<Datum> data = state.data.data!;
            print('panjg : ${data.length}');
          }
        },
        builder: (context, state) {
          if (state is BerkalaSucces) {
            List<Datum> data = state.data.data!;
            if (data.isEmpty) {
              return const Center(child: Text('Data Kosong !'));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Center(
                                child: CircleNumber(
                                  color: Colors.blue,
                                  number: index + 1,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      '${data[index].noSkBaru}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text('${data[index].kenaikanPangkat}'),
                                  Text('Golongan : ${data[index].kdGolBaru}'),
                                  Text('TMT : ${data[index].tmtBaru}'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed(
                                  Routes.readPdf,
                                  queryParameters: {
                                    'file': '${data[index].file}',
                                    'link':
                                        'uploads/${data[index].nik}/Berkala/',
                                  },
                                );
                                // _onItemTapped('${data[index].file}');
                              },
                              child: const Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(Icons.picture_as_pdf, size: 20),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          endIndent: 10,
                          indent: 10,
                          height: 5,
                          thickness: 1,
                          color: Colors.black12,
                        ),
                        SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            );
          }
          return const Center(child: Text('Data Kosong !'));
        },
      ),
    );
  }
}
