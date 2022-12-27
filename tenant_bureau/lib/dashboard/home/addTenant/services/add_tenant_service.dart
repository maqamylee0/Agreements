import 'dart:collection';
import 'dart:core';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../main.dart';


class AddTenantMethod{
  // late final Box box1;

  Future addTenants(context,data) async {
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      await firebaseFirestore
          .collection("tenants")
          .add(data.toMap());

      Fluttertoast.showToast(msg: "Data saved successfully");
      navigatorKey.currentState!.popUntil((route)=>route.isFirst);

    } on FirebaseException catch(e){
      // navigatorKey.currentState!.popUntil((route)=>route.isFirst);
      Navigator.pop(context);
      if (kDebugMode) {
        print(e);
      }
      Fluttertoast.showToast(msg:'${e.message}');

    }
  }
}