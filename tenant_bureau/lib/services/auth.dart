
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_bureau/views/home.dart';
import 'package:tenant_bureau/views/reset.dart';
import 'package:tenant_bureau/views/verifyEmail.dart';

import '../../main.dart';
import '../dashboard/home/Tenants.dart';
import '../dashboard/home/addTenant/models/tenant.dart';
import '../dashboard/home/home.dart';

class Auth{
  String? errorMessage;
  final _auth = FirebaseAuth.instance;

  Future signUp(String email, String password,userModel,context) async {
    // if (_formKey.currentState!.validate()) {
    // final directory = await getApplicationDocumentsDirectory();
    // box1 = await Hive.openBox('personaldata');


    try {
      showDialog(context: context,barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()));
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => { postDetailsToFirestore(userModel,context)})
          .catchError((e) {
        Navigator.pop(context);

        Fluttertoast.showToast(msg: e!.message);

      });
    } on FirebaseAuthException catch (error) {

      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      Fluttertoast.showToast(msg: errorMessage!);
      Navigator.pop(context);

      print(error.code);
    }
    // navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
  postDetailsToFirestore(userModel,context) async {
    User? user=_auth.currentUser;
    userModel.email = user!.email;
    userModel.uid = user!.uid;
    // sendVerificationCode(context, userModel.email );

    //save uid of user in local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', '${user!.uid}');

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  VerifyEmailPage())

    );
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // box1.put('userid', user!.uid);

    await firebaseFirestore
        .collection("users")
        .doc(userModel.uid)
        .set(userModel.toMap());

    Fluttertoast.showToast(msg: "Account created successfully :) ");

  }
  Future signIn(context,email,password) async {

    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password:password.trim());

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Home())

      );
    } on FirebaseException catch(e){
      // navigatorKey.currentState!.popUntil((route)=>route.isFirst);
      Navigator.pop(context);
      if (kDebugMode) {
        print(e);
      }
      Fluttertoast.showToast(msg:'${e.message}');

    }

    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }

  Future<void> passwordReset(String? email,context) async {
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    final _auth = FirebaseAuth.instance;
    try {
      // _formKey.currentState?.save();

      await _auth.sendPasswordResetEmail(email: email!);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return MyReset();
        }),
      );
    } catch (e) {
      print(e);
    }
  }
  Future<Map> getTenant(context, query) async {
    late Map<dynamic, dynamic> doc ;
    // showDialog(context: context,barrierDismissible: false,
    //     builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

        await mFirebaseFirestore.collection('tenants')
        .where('nin', isEqualTo: query)
        .get()
        .then((snapshot) {
            doc = snapshot.docs[0].data() ;
          });

  } catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    print(doc['nin']);
    return doc;
  }

  Future<List<TenantModel>> getAllTenants(query) async {
  List<TenantModel> listOfTenants = [];
    try{
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

      await mFirebaseFirestore.collection('tenants')
          .where('landlordUid', isEqualTo: query)
          .get()
          .then((snapshot) {
            snapshot.docs.forEach((element) {
              TenantModel tenants = TenantModel.fromJson(Map<String, dynamic>.from(element.data()));
               listOfTenants.add(tenants);
            });
        // listOfTenants = snapshot.docs. ;
      });

    } catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
    return listOfTenants;
  }
}