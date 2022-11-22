import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/register.dart';
import 'Utils.dart';
import 'login.dart';
import 'models/welcome.dart';


final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(MaterialApp(

    scaffoldMessengerKey: Utils.messengerKey,
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    home: Welcome(),
    routes: {
      'register': (context) => const MyRegister(),
      'login': (context) => const MyLogin(),
      'welcome': (context) => const Welcome(),

    },
  ));
}
