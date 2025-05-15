import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simprodis_flutter/bloc/cuci_filter_cubit/cuci_filter_cubit.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/widgets/checkboxDropdown.dart';

class CuciFilterScreen extends StatelessWidget {
  const CuciFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cuciFilterCubit = CuciFilterCubit();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(0, 81, 135, 1), Colors.white],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "IPA",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Cuci Filter',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 81, 135, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        toolbarHeight: 120.0, // Adjust the height of the AppBar
        // flexibleSpace: Center(child: Text("data")),
        centerTitle: false, // We are manually centering it here
      ),
      body: BlocBuilder<InstalasiCubit, InstalasiState>(
        builder: (context, state) {
          if (state is InstalasiSuccess && state.selectedInstalasi != null) {
            final displayName =
                state.data
                    .firstWhere(
                      (instalasi) =>
                          instalasi.idInstalasi == state.selectedInstalasi,
                    )
                    .namaInstalasi;
            cuciFilterCubit.fetchData(idInstalasi: state.selectedInstalasi);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(242, 240, 240, 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Instalasi",
                            style: TextStyle(
                              color: Color.fromRGBO(0, 81, 135, 1),
                            ),
                          ),
                          BlocBuilder<InstalasiCubit, InstalasiState>(
                            builder: (context, state) {
                              if (state is InstalasiSuccess) {
                                return Text(
                                  '$displayName',
                                  style: TextStyle(
                                    color: Color.fromRGBO(0, 81, 135, 1),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Text("Failed to load !");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 250, 250, 1),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<CuciFilterCubit, CuciFilterState>(
                            bloc: cuciFilterCubit,
                            builder: (context, stateCuciFilter) {
                              if (stateCuciFilter is CuciFilterSuccess) {
                                List<String> data =
                                    stateCuciFilter.data
                                        .map((e) => e.toString())
                                        .toList();
                                return CheckboxDropdownFromArray(
                                  items: data,
                                  onItemSelected: (List<String> selectedItems) {
                                    cuciFilterCubit.selectItems(selectedItems);
                                  },
                                );
                              } else if (stateCuciFilter is CuciFilterError) {
                                return Center(
                                  child: Text(
                                    "Error: ${stateCuciFilter.message}",
                                  ),
                                );
                              }
                              return Text("......");
                            },
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: BlocConsumer<
                                CuciFilterCubit,
                                CuciFilterState
                              >(
                                bloc: cuciFilterCubit,
                                listener: (context, stateCuciFilter) {
                                  if (stateCuciFilter is CuciFilterError) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Gagal : ${stateCuciFilter.message.toString()}",
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } else if (stateCuciFilter
                                      is CuciFilterSuccessInsert) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "Berhasil : ${stateCuciFilter.message.toString()}",
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  }
                                },
                                builder: (context, stateCuciFilter) {
                                  if (stateCuciFilter is CuciFilterLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return ElevatedButton.icon(
                                      onPressed: () {
                                        if (stateCuciFilter
                                                is CuciFilterSuccess &&
                                            stateCuciFilter.selectedItems ==
                                                []) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Please select at least one item.",
                                              ),
                                            ),
                                          );
                                          return;
                                        }
                                        cuciFilterCubit.simpan(
                                          id_instalasi: state.selectedInstalasi,
                                          tanggal: state.selectedTanggal,
                                          jam: state.selectedJam,
                                          cuci_filter:
                                              (stateCuciFilter
                                                      as CuciFilterSuccess)
                                                  .selectedItems,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        "Simpan",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is InstalasiLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is InstalasiError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return Center(child: Text("Gagal"));
          }
        },
      ),
    );
  }
}
