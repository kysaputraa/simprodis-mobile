import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simprodis_flutter/model/jabatan_model.dart';
import 'package:simprodis_flutter/screens/jabatan/bloc/jabatan_bloc.dart';
import 'package:simprodis_flutter/widgets/list_card.dart';

class ListJabatan extends StatelessWidget {
  ListJabatan({super.key});

  final JabatanBloc jabatanBloc = JabatanBloc();

  @override
  Widget build(BuildContext context) {
    jabatanBloc.add(JabatanEventFetch());
    return Scaffold(
      appBar: AppBar(
        // forceMaterialTransparency: true,
        backgroundColor: Colors.amber,
        title: const Text(
          'Riwayat Jabatan Saya',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(color: Colors.amber, height: 75),
          BlocConsumer(
            bloc: jabatanBloc,
            listener: (context, state) {
              if (state is JabatanSucces) {
                // List<Datum> data = state.data.data;
                // print('panjg : ${data.length}');
              }
            },
            builder: (context, state) {
              if (state is JabatanSucces) {
                List<Datum> data = state.data.data!;
                if (data.isEmpty) {
                  return const Center(child: Text('Data Kosong !'));
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          // return Column(
                          //   children: [
                          //     Row(
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.all(15.0),
                          //           child: Center(
                          //             child: Text(
                          //               (index + 1).toString(),
                          //               style: const TextStyle(fontSize: 16),
                          //             ),
                          //           ),
                          //         ),
                          //         Expanded(
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 'Jabatan : ${data[index].namaJabatan2}',
                          //                 style: TextStyle(
                          //                     fontWeight: FontWeight.bold),
                          //               ),
                          //               Text(
                          //                   'Lorem ipsum dolor sit amet consectetur adipisicing elit. At officia, numquam quasi nemo dolore quod?')
                          //             ],
                          //           ),
                          //         ),
                          //         const Padding(
                          //           padding: const EdgeInsets.all(10),
                          //           child: Icon(Icons.edit, size: 24),
                          //         )
                          //       ],
                          //     ),
                          //     const Divider(
                          //       endIndent: 10,
                          //       indent: 10,
                          //       height: 5,
                          //       thickness: 2,
                          //       color: Colors.black45,
                          //     ),
                          //   ],
                          // );
                          DateTime dateTime = DateTime.parse(
                            '${data[index].tglSk}',
                          );
                          String formattedDate = DateFormat(
                            'yyyy-MM-dd',
                          ).format(dateTime);

                          DateTime dateTimeTMT = DateTime.parse(
                            '${data[index].tmt}',
                          );
                          String tmt = DateFormat(
                            'yyyy-MM-dd',
                          ).format(dateTimeTMT);

                          return ListCard(
                            judul: '${data[index].namaJabatan2}',
                            tanggal: formattedDate,
                            title: '${data[index].noSk}',
                            isi:
                                'Terhitung dari tanggal ${tmt} saudara di tetapkan sebagai ${data[index].namaJabatan2}, Keterangan : ${data[index].keterangan}',
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(child: Text('Data Kosong !'));
            },
          ),
        ],
      ),
    );
  }
}
