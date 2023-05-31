import 'dart:collection';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tenant_bureau/dashboard/home/list_tenants/tenant_list.dart';

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

      Fluttertoast.showToast(msg: "Tenant added successfully");
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TenantList()));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) =>  TenantList())
      //
      // );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TenantList()),
            (Route<dynamic> route) => false,
      );
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