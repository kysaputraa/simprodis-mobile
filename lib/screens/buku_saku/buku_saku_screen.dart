import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/model/skdireksi_model.dart';
import 'package:simprodis_flutter/routes/router.dart';
import 'package:simprodis_flutter/screens/buku_saku/bloc/buku_saku_bloc.dart';
// import 'package:intl/intl.dart';

class BukuSakuScreen extends StatelessWidget {
  BukuSakuScreen({super.key});

  final BukuSakuBloc bukuSakuBloc = BukuSakuBloc();

  @override
  Widget build(BuildContext context) {
    bukuSakuBloc.add(BukuSakuEventFetch());
    return Scaffold(
      appBar: AppBar(
        // forceMaterialTransparency: true,
        backgroundColor: Colors.blue[100],
        title: const Text(
          'LIST BUKU SAKU',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocConsumer(
        bloc: bukuSakuBloc,
        listener: (context, state) {
          if (state is BukuSakuSuccess) {
            // List<Datum> data = state.data.data;
            // print('panjg : ${data.length}');
          }
        },
        builder: (context, state) {
          if (state is BukuSakuSuccess) {
            List<Datum> data = state.data.data!;
            if (data.isEmpty) {
              return const Center(child: Text('Data Kosong !'));
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          // DateTime dateTime = DateTime.parse(
                          //   '${data[index].createdAt}',
                          // );
                          // String createdAt = DateFormat(
                          //   'yyyy-MM-dd',
                          // ).format(dateTime);
                          // int nomor = index + 1;

                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                Routes.readPdf,
                                queryParameters: {
                                  'file': '${data[index].file}',
                                  'link': 'uploads/MSkDireksi/',
                                },
                              );
                              // _onItemTapped('${data[index].file}');
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                        child: Text(
                                          (index + 1).toString(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${data[index].nama}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          // Text(
                                          //     'Hubungan : ${data[index].createdAt}')
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.picture_as_pdf,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  endIndent: 10,
                                  indent: 10,
                                  height: 5,
                                  thickness: 2,
                                  color: Colors.black45,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
