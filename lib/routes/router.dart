import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simprodis_flutter/screens/ConvexBottom/convexBottom.dart';
import 'package:simprodis_flutter/screens/bahan_kimia_screen.dart';
import 'package:simprodis_flutter/screens/beranda/beranda_screen.dart';
import 'package:simprodis_flutter/screens/cuci_filter_screen.dart';
import 'package:simprodis_flutter/screens/flowmeter_screen.dart';
import 'package:simprodis_flutter/screens/home/home_screen.dart';
import 'package:simprodis_flutter/screens/intake/booster_screen.dart';
import 'package:simprodis_flutter/screens/intake/intake_screen.dart';
import 'package:simprodis_flutter/screens/intake/ipa_screen.dart';
import 'package:simprodis_flutter/screens/intake/laboratorium_screen.dart';
import 'package:simprodis_flutter/screens/listrik_padam_screen.dart';
import 'package:simprodis_flutter/screens/kualitas_air_konsumen_screen.dart';
import 'package:simprodis_flutter/screens/kualtias_air_harian.dart';
import 'package:simprodis_flutter/screens/kualtias_air_lengkap_screen.dart';
import 'package:simprodis_flutter/screens/kwh/kwh_screen.dart';
import 'package:simprodis_flutter/screens/login/LoginScreen.dart';
import 'package:simprodis_flutter/screens/ph_screen.dart';
import 'package:simprodis_flutter/screens/pompa/kelompok_pompa_screen.dart';
import 'package:simprodis_flutter/screens/pompa/pompa_screen.dart';
import 'package:simprodis_flutter/screens/pompa_padam_screen.dart';
// import 'package:simprodis_flutter/screens/pressure/kelompok_pressure_screen.dart';
// import 'package:simprodis_flutter/screens/pressure/pressure_screen.dart';
import 'package:simprodis_flutter/screens/pressure/pressure_screen_2.dart';
// import 'package:simprodis_flutter/screens/reservoir/kelompok_reservoir.dart';
// import 'package:simprodis_flutter/screens/reservoir/reservoir_screen.dart';
import 'package:simprodis_flutter/screens/reservoir/reservoir_screen2.dart';
import 'package:simprodis_flutter/screens/scada_screen.dart';
import 'package:simprodis_flutter/screens/spey_clarif_screen.dart';
import 'package:simprodis_flutter/screens/stand_meter/kelompok_stand_meter_screen.dart';
import 'package:simprodis_flutter/screens/stand_meter/stand_meter_screen.dart';
import 'package:simprodis_flutter/screens/tinggi_sungai/tinggi_sungai_screen.dart';
import 'package:simprodis_flutter/screens/userSetting/user_settings.dart';
import 'package:simprodis_flutter/screens/voltage/voltage_screen.dart';
// import 'package:simprodis_flutter/screens/buku_saku/buku_saku_screen.dart';
// import 'package:simprodis_flutter/screens/detail/DetailScreen.dart';
// import 'package:simprodis_flutter/screens/jabatan/list_jabatan_screen.dart';
// import 'package:simprodis_flutter/screens/keluarga/list_keluarga_screen.dart';
// import 'package:simprodis_flutter/screens/listBerkala/list_berkala_screen.dart';
// import 'package:simprodis_flutter/screens/pendidikan/pendidikan_list.dart';
// import 'package:simprodis_flutter/screens/readPdf/read_pdf.dart';
part 'route_name.dart';

final router = GoRouter(
  redirect: (BuildContext context, GoRouterState state) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      return null;
    } else {
      return '/${Routes.loginScreen}';
    }
  },
  routes: [
    GoRoute(
      path: '/${Routes.loginScreen}',
      name: Routes.loginScreen,
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: '/${Routes.berandaScreen}',
      name: Routes.berandaScreen,
      builder: (BuildContext context, GoRouterState state) {
        return BerandaScreen();
      },
    ),
    GoRoute(
      path: '/',
      name: Routes.bottomNavbar,
      builder: (BuildContext context, GoRouterState state) {
        return HelloConvexAppBar();
      },
      routes: [
        GoRoute(
          path: '/${Routes.intakeScreen}',
          name: Routes.intakeScreen,
          builder: (BuildContext context, GoRouterState state) {
            return IntakeScreen();
          },
          routes: [
            GoRoute(
              path: '/${Routes.kwhScreen}',
              name: Routes.kwhScreen,
              builder: (BuildContext context, GoRouterState state) {
                return KwhScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.tinggiSungaiScreen}',
              name: Routes.tinggiSungaiScreen,
              builder: (BuildContext context, GoRouterState state) {
                return TinggiSungaiScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.voltageScreen}',
              name: Routes.voltageScreen,
              builder: (BuildContext context, GoRouterState state) {
                return VolatageScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.pressureScreen2}',
              name: Routes.pressureScreen2,
              builder: (BuildContext context, GoRouterState state) {
                return PressureScreen2();
              },
            ),
            // GoRoute(
            //   path: '/${Routes.kelompokPressureScreen}',
            //   name: Routes.kelompokPressureScreen,
            //   builder: (BuildContext context, GoRouterState state) {
            //     return KelompokPressureScreen();
            //   },
            //   routes: [
            //     GoRoute(
            //       path: '/${Routes.pressureScreen}',
            //       name: Routes.pressureScreen,
            //       builder: (BuildContext context, GoRouterState state) {
            //         return PressureScreen(
            //           idKelompok: state.uri.queryParameters['idKelompok'],
            //           namaKelompok: state.uri.queryParameters['namaKelompok'],
            //         );
            //       },
            //     ),
            //   ],
            // ),
            GoRoute(
              path: '/${Routes.kelompokPompaScreen}',
              name: Routes.kelompokPompaScreen,
              builder: (BuildContext context, GoRouterState state) {
                return KelompokPompaScreen();
              },
              routes: [
                GoRoute(
                  path: '/${Routes.pompaScreen}',
                  name: Routes.pompaScreen,
                  builder: (BuildContext context, GoRouterState state) {
                    return PompaScreen(
                      idKelompok: state.uri.queryParameters['idKelompok'],
                      namaKelompok: state.uri.queryParameters['namaKelompok'],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/${Routes.ipaScreen}',
          name: Routes.ipaScreen,
          builder: (BuildContext context, GoRouterState state) {
            return IpaScreen();
          },

          routes: [
            // GoRoute(
            //   path: '/${Routes.kelompokReservoirScreen}',
            //   name: Routes.kelompokReservoirScreen,
            //   builder: (BuildContext context, GoRouterState state) {
            //     return KelompokReservoirScreen();
            //   },
            //   routes: [
            //     GoRoute(
            //       path: '/${Routes.reservoirScreen}',
            //       name: Routes.reservoirScreen,
            //       builder: (BuildContext context, GoRouterState state) {
            //         return ReservoirScreen(
            //           idKelompok: state.uri.queryParameters['idKelompok'],
            //           namaKelompok: state.uri.queryParameters['namaKelompok'],
            //         );
            //       },
            //     ),
            //   ],
            // ),
            GoRoute(
              path: '/${Routes.reservoirScreen2}',
              name: Routes.reservoirScreen2,
              builder: (BuildContext context, GoRouterState state) {
                return ReservoirScreen2();
              },
            ),
            GoRoute(
              path: '/${Routes.kelompokStandMeterScreen}',
              name: Routes.kelompokStandMeterScreen,
              builder: (BuildContext context, GoRouterState state) {
                return KelompokStandMeterScreen();
              },
              routes: [
                GoRoute(
                  path: '/${Routes.standMeterScreen}',
                  name: Routes.standMeterScreen,
                  builder: (BuildContext context, GoRouterState state) {
                    return StandMeterScreen(
                      idKelompok: state.uri.queryParameters['idKelompok'],
                      namaKelompok: state.uri.queryParameters['namaKelompok'],
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/${Routes.bahanKimiaScreen}',
              name: Routes.bahanKimiaScreen,
              builder: (BuildContext context, GoRouterState state) {
                return BahanKimiaScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.phScreen}',
              name: Routes.phScreen,
              builder: (BuildContext context, GoRouterState state) {
                return PhScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.scadarScreen}',
              name: Routes.scadarScreen,
              builder: (BuildContext context, GoRouterState state) {
                return ScadaScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.flowmeterScreen}',
              name: Routes.flowmeterScreen,
              builder: (BuildContext context, GoRouterState state) {
                return FlowmeterScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.speyClarifScreen}',
              name: Routes.speyClarifScreen,
              builder: (BuildContext context, GoRouterState state) {
                return SpeyClarifScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.cuciFilterScreen}',
              name: Routes.cuciFilterScreen,
              builder: (BuildContext context, GoRouterState state) {
                return CuciFilterScreen();
              },
            ),
          ],
        ),
        GoRoute(
          path: '/${Routes.boosterScreen}',
          name: Routes.boosterScreen,
          builder: (BuildContext context, GoRouterState state) {
            return BoosterScreen();
          },
        ),

        GoRoute(
          path: '/${Routes.listrikPadamScreen}',
          name: Routes.listrikPadamScreen,
          builder: (BuildContext context, GoRouterState state) {
            return ListrikPadamScreen();
          },
        ),
        GoRoute(
          path: '/${Routes.pompaPadamScreen}',
          name: Routes.pompaPadamScreen,
          builder: (BuildContext context, GoRouterState state) {
            return PompaPadamScreen();
          },
        ),
        GoRoute(
          path: '/${Routes.laboratoriumScreen}',
          name: Routes.laboratoriumScreen,
          builder: (BuildContext context, GoRouterState state) {
            return LaboratoriumScreen();
          },
          routes: [
            GoRoute(
              path: '/${Routes.kualitasAirHarianScreen}',
              name: Routes.kualitasAirHarianScreen,
              builder: (BuildContext context, GoRouterState state) {
                return KualitasAirHarianScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.kualitasAirLengkapScreen}',
              name: Routes.kualitasAirLengkapScreen,
              builder: (BuildContext context, GoRouterState state) {
                return KualitasAirLengkapScreen();
              },
            ),
            GoRoute(
              path: '/${Routes.kualitasAirKonsumenScreen}',
              name: Routes.kualitasAirKonsumenScreen,
              builder: (BuildContext context, GoRouterState state) {
                return KualitasAirKonsumenScreen();
              },
            ),
          ],
        ),
      ],
    ),

    // -------------------------
    GoRoute(
      path: '/${Routes.userSettings}',
      name: Routes.userSettings,
      builder: (BuildContext context, GoRouterState state) {
        return const UserSettings();
      },
    ),
    GoRoute(
      path: '/${Routes.homeScreen}',
      name: Routes.homeScreen,
      builder: (BuildContext context, GoRouterState state) {
        return HomeScreen();
      },
    ),
  ],
);
