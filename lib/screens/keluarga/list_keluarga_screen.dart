import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/model/keluarga_model.dart';
import 'package:simprodis_flutter/screens/keluarga/bloc/keluarga_bloc.dart';
import 'package:simprodis_flutter/widgets/loading_widget.dart';

class ListKeluarga extends StatelessWidget {
  ListKeluarga({super.key});

  final KeluargaBloc keluargaBloc = KeluargaBloc();

  @override
  Widget build(BuildContext context) {
    keluargaBloc.add(KeluargaEventFetch());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Data Keluarga Saya',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer(
        bloc: keluargaBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is KeluargaLoading) {
            return const LoadingWidget();
          }
          if (state is KeluargaSucces) {
            List<Data> data = state.data.data!;
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
                          return Column(
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
                                          'Nama : ${data[index].nama}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Hubungan : ${data[index].statuskeluarga}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Icon(Icons.people_rounded, size: 24),
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
