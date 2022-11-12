import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/register.dart';
import 'Utils.dart';
import 'login.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  final navigatorKey = GlobalKey<NavigatorState>();

  runApp(MaterialApp(

    scaffoldMessengerKey: Utils.messengerKey,
    navigatorKey:  navigatorKey,
    debugShowCheckedModeBanner: false,
    home: MyLogin(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
    },
  ));
}
