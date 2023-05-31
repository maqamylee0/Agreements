
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_bureau/rating/model/rate_model.dart';
import 'package:tenant_bureau/views/home.dart';
import 'package:tenant_bureau/views/reset.dart';
import 'package:tenant_bureau/views/verifyEmail.dart';

import '../../main.dart';
import '../dashboard/home/Tenants.dart';
import '../dashboard/home/addTenant/models/tenant.dart';
import '../dashboard/home/home.dart';
import '../models/User.dart';

class Auth{
  String? errorMessage;
  final _auth = FirebaseAuth.instance;

  Future signUp(String email, String password,userModel,context) async {
    // if (_formKey.currentState!.validate()) {
    // final directory = await getApplicationDocumentsDirectory();
    // box1 = await Hive.openBox('personaldata');
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {

      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => { postDetailsToFirestore(userModel,context)})
          .catchError((e) {

        Fluttertoast.showToast(msg: e!.message);
        navigatorKey.currentState!.popUntil((route)=>route.isFirst);

      });
      Navigator.pop(context);

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
      navigatorKey.currentState!.popUntil((route)=>route.isFirst);

      Fluttertoast.showToast(msg: errorMessage!);
      Navigator.pop(context);

      print(error.code);
    }
    // navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }
  postDetailsToFirestore(UserModel userModel,BuildContext context) async {
    User? user=_auth.currentUser;
    userModel.email = user!.email;
    userModel.uid = user!.uid;
    // sendVerificationCode(context, userModel.email );

    //save uid of user in local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userid', '${user!.uid}');
    await prefs.setString('username', '${userModel.name}');

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  VerifyEmailPage(name:'${userModel.name}'))

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
    final prefs = await SharedPreferences.getInstance();
    final name2 = await prefs.getString('username');
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password:password.trim());
          print('logged innnnnnnnn');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>  Home())

      );
    } on FirebaseException catch(e){
      // navigatorKey.currentState!.popUntil((route)=>route.isFirst);
      Navigator.pop(context);
      if (kDebugMode) {
        print(e);
      }
      Fluttertoast.showToast(msg:'${e.message}');

    }

    // navigatorKey.currentState!.popUntil((route)=>route.isFirst);
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
  Future getUserName() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    String? name = await firebaseAuth.currentUser?.displayName;
    // var prefs = await SharedPreferences.getInstance();
    // var name = await prefs.getString('username');
    print(name);
    return name;
  }
  Future<List<RateModel>> getTenant(query) async {
    late Map<dynamic, dynamic> doc ;
    List<RateModel> listOfRates = [];    // showDialog(context: context,barrierDismissible: false,
    //     builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

        await mFirebaseFirestore.collection('rates')
        .where('nin', isEqualTo: query)
        .get()
        .then((snapshot) {
          snapshot.docs.forEach((element) {
            RateModel tenantRate = RateModel.fromJson(Map<String, dynamic>.from(element.data()));
            listOfRates.add(tenantRate);
          });          });

  } catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
    return listOfRates;
  }
  Future<UserModel> getUser(String uid) async {
    late Map<dynamic, dynamic> doc ;
    UserModel? user;
    // List<RateModel> listOfRates = [];    // showDialog(context: context,barrierDismissible: false,
    //     builder: (context) => const Center(child: CircularProgressIndicator()));
    try{
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

      await mFirebaseFirestore.collection('users')
          .where('uid', isEqualTo: uid)
          .get()
          .then((snapshot) {

           user =  UserModel.fromJson(snapshot.docs.single.data());
           print(snapshot.docs.asMap());

      });
      //   print(user?.email);
      // print(user?.nin);
      // print(user?.name);

    } catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
    return user!;
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
  Future sendRating(RateModel rateModel, TenantModel tenant,context) async{
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      User? user = _auth.currentUser;
      rateModel.emailLandLord = user!.email;
      rateModel.landlordUid = user!.uid;
      rateModel.nameTenant = tenant.name;
      rateModel.ninTenant = tenant.nin;
      // sendVerificationCode(context, userModel.email );
      // print(tenant.name);
      //save uid of user in local storage


      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) =>  VerifyEmailPage())
      //
      // );
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      // box1.put('userid', user!.uid);
      await firebaseFirestore
          .collection("rates")
          .add(rateModel.toMap());

      Fluttertoast.showToast(msg: "Rating created successfully :) ");
      // navigatorKey.currentState!.popUntil((route)=>route.);
      Navigator.of(context).pop();

    } catch (e) {
      print(e);
    }
  }
  Future<List<RateModel>> getAllTenantRates(query) async {
    List<RateModel> listOfRates = [];
    try{
      FirebaseFirestore mFirebaseFirestore = FirebaseFirestore.instance;

      await mFirebaseFirestore.collection('rates')
          .where('ninTenant', isEqualTo: query)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((element) {
          RateModel tenantRate = RateModel.fromJson(Map<String, dynamic>.from(element.data()));
          listOfRates.add(tenantRate);
        });
        // listOfTenants = snapshot.docs. ;
      });

    } catch (e) {
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route)=>route.);
    // print(doc['nin']);
    return listOfRates;
  }
}


