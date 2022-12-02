

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/views/register.dart';
import 'views/Utils.dart';
import 'views/login.dart';
import 'views/welcome.dart';


final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Manrope',
      ),
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Welcome(),
      routes: {
        'register': (context) => const MyRegister(),
        'login': (context) => const MyLogin(),
        'welcome': (context) => const Welcome(),

      },
    );
  }
}