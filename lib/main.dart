import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simprodis_flutter/bloc/instalasi_cubit/instalasi_cubit.dart';
import 'package:simprodis_flutter/routes/router.dart';
import 'package:simprodis_flutter/screens/home/bloc_pegawai/pegawai_bloc.dart';
import 'package:simprodis_flutter/screens/login/bloc/auth_bloc.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // await FirebaseMessaging.instance.subscribeToTopic('Tes');
  // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(pak
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // Request permission
  await requestPermission();

  await dotenv.load(fileName: "assets/env/.env_production");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PegawaiBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => InstalasiCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          // scaffoldBackgroundColor: Colors.grey.shade200,
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: Colors.blue,
            secondary: Colors.amber,
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for iOS devices`
  NotificationSettings settings = await messaging.requestPermission();

  // Check if permission was granted
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("Notification permission granted");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print("Notification permission granted provisionally");
  } else {
    print("Notification permission denied");
  }
}

Future<void> requestPermission() async {
  Map<Permission, PermissionStatus> statuses =
      await [
        Permission.camera,
        Permission.storage,
        Permission.location,
        Permission.notification,
      ].request();
  statuses.forEach((key, value) async {
    if (value.isGranted) {
      print('Permission granted');
    } else {
      await key.request();
    }
  });
}
