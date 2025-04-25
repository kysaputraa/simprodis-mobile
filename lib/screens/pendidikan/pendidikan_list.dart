import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/model/pendidikan_model.dart';
import 'package:simprodis_flutter/screens/Pendidikan/bloc/pendidikan_bloc.dart';
import 'package:simprodis_flutter/widgets/list_card.dart';

class ListPendidikan extends StatelessWidget {
  ListPendidikan({super.key});

  final PendidikanBloc pendidikanBloc = PendidikanBloc();

  @override
  Widget build(BuildContext context) {
    pendidikanBloc.add(PendidikanEventFetch());
    return Scaffold(
      appBar: AppBar(
        // forceMaterialTransparency: true,
        backgroundColor: Colors.blue[100],
        title: const Text(
          'Riwayat Pendidikan Saya',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(color: Colors.blue[100], height: 75),
          BlocConsumer(
            bloc: pendidikanBloc,
            listener: (context, state) {
              if (state is PendidikanSucces) {
                // List<Datum> data = state.data.data;
                // print('panjg : ${data.length}');
              }
            },
            builder: (context, state) {
              if (state is PendidikanSucces) {
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
                          return ListCard(
                            judul: '${data[index].namaSekolah}',
                            tanggal: '${data[index].tahunLulus}',
                            title: '${data[index].tempatLulus}',
                            isi: '${data[index].tingkatpendidikan}',
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
