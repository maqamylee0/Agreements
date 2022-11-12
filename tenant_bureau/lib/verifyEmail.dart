import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/home.dart';

import 'Utils.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
    bool isVerified = false;
    bool canResend = false;
    Timer? timer;

    @override
  void initState() {
    super.initState();
    isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    
    if(!isVerified){
      sendVerifyEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),(_)=>{
          checkEmailVerified(),
      }
      );
    }
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) =>
      isVerified ? HomePage() :
     Center(
       child: Column(
         children: [
           Text("A verification email has been sent to your email"),
           SizedBox(
             height: 30,
           ),
           ElevatedButton.icon(style:ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),),
               icon: Icon(Icons.email,size: 32),
             label: Text("Resend Email",
                 style:TextStyle(fontSize: 24)),
           onPressed: () {
            canResend? sendVerifyEmail() : null;
           },),
           SizedBox(
             height: 30,
           ),
           ElevatedButton.icon(style:ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),),
             icon: Icon(Icons.email,size: 32),
             label: Text("Cancel",
                 style:TextStyle(fontSize: 24)),
             onPressed: () => FirebaseAuth.instance.signOut()
             ),
         ],
       )

     );

  Future sendVerifyEmail() async {
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResend= false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResend= true;
      });
    } on FirebaseAuthException catch (e){
      print(e);
      Utils.showSnackBar(e.message);
    }

  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isVerified) timer?.cancel();
  }
  }

