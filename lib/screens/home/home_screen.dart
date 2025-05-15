import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simprodis_flutter/routes/router.dart';
import 'package:simprodis_flutter/screens/home/bloc_pegawai/pegawai_bloc.dart';
import 'package:simprodis_flutter/widgets/card_top.dart';
import 'package:simprodis_flutter/widgets/card_bottom.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // final PegawaiBloc pegawaiBloc = PegawaiBloc();

  @override
  Widget build(BuildContext context) {
    // pegawaiBloc.add(PegawaiEventFetch());
    // context.read<PegawaiBloc>().add(PegawaiEventFetch());
    context.read<PegawaiBloc>().add(PegawaiEventFetch());

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PegawaiBloc>().add(PegawaiEventFetch());
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocConsumer<PegawaiBloc, PegawaiState>(
                          listener: (context, state) {
                            if (state is PegawaiError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Failed : ${state.message}"),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return BlocBuilder<PegawaiBloc, PegawaiState>(
                              builder: (context, state) {
                                if (state is PegawaiSuccess) {
                                  return Text(
                                    "Hi, ${state.data.data?.nama}",
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                                return const Text(
                                  "Hi, .............",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const Text(
                          "Selamat datang di SIMPEG",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 260,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CardTop(
                          judul: 'Data Berkala',
                          color: Colors.red,
                          onTap: () {
                            context.pushNamed(Routes.listBerkala);
                          },
                        ),
                        CardTop(
                          judul: 'Data Keluarga',
                          color: Colors.blue,
                          onTap: () {
                            context.pushNamed(Routes.listKeluarga);
                          },
                        ),
                        CardTop(
                          judul: 'Data Jabatan',
                          color: Colors.amber,
                          onTap: () {
                            context.pushNamed(Routes.listJabatan);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      "Menu",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    CardBottom(
                      judul: 'Riwayat Pendidikan',
                      icon: Icons.school,
                      onTap: () {
                        context.pushNamed(Routes.listPendidikan);
                      },
                    ),
                    CardBottom(
                      judul: 'Riwayat Pelatihan',
                      icon: Icons.auto_stories,
                      onTap: () {
                        context.pushNamed(Routes.listKeluarga);
                      },
                    ),
                    CardBottom(
                      judul: 'Riwayat Cuti',
                      icon: Icons.mood,
                      onTap: () {
                        context.pushNamed(Routes.listKeluarga);
                      },
                    ),
                    CardBottom(
                      judul: 'Riwayat Penghargaan',
                      icon: Icons.emoji_events,
                      onTap: () {
                        context.pushNamed(Routes.listKeluarga);
                      },
                    ),
                    CardBottom(
                      judul: 'Riwayat Hukuman',
                      icon: Icons.not_interested,
                      onTap: () {
                        context.pushNamed(Routes.listKeluarga);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
