

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/dashboard/home/newhome.dart';
import 'package:tenant_bureau/views/register.dart';
import 'package:tenant_bureau/views/reset.dart';
import 'package:tenant_bureau/views/verifyEmail.dart';
import 'views/Utils.dart';
import 'views/login.dart';
import 'views/welcome.dart';

import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
  // MyApp());
    DevicePreview(
      builder: (BuildContext context)=> const MyApp(),
    ));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Manrope',
        primarySwatch:Colors.brown
      ),
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: NewHome(),
      routes: {
        'register': (context) => const MyRegister(),
        'login': (context) => const MyLogin(),
        'welcome': (context) => const Welcome(),
        'reset':(context) => const Reset(),

      },
    );
  }
}