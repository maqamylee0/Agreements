import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/dashboard/home/home.dart';
import 'package:tenant_bureau/views/login.dart';

import '../utils.dart';
import 'Utils.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key, required this.name}) : super(key: key);
 final String name;
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
      isVerified ?  Home() :

         Scaffold(
         backgroundColor: Colors.white,

         body:Center(

             child:
             Container(

               padding: EdgeInsets.fromLTRB(50, 100, 50, 100),
               child: Column(
                 children: [
                   SizedBox(height: 100,),
                   const Text("A verification email has been sent to your email\n"
                       "Check your spam if you cannot find it " ,
                       style: TextStyle(fontSize: 27,fontWeight: FontWeight.w600,)),
                  SizedBox(height: 30,),
                   ElevatedButton.icon(style:ElevatedButton.styleFrom(
                       primary: Statics.thirdColor,
                     minimumSize: Size.fromHeight(60),),
                     icon: const Icon(Icons.email,size: 32),
                     label: const Text("Resend Email",
                         style:TextStyle(fontSize: 24)),
                     onPressed: () {
                       canResend? sendVerifyEmail() : null;
                     },),
                   const SizedBox(
                     height: 30,
                   ),
                   ElevatedButton.icon(style:ElevatedButton.styleFrom(
                     primary: Statics.thirdColor,
                     minimumSize: Size.fromHeight(60),),
                       icon: Icon(Icons.email,size: 32),
                       label: const Text("Cancel",
                           style:TextStyle(fontSize: 24)),
                       onPressed: () => FirebaseAuth.instance.signOut()
                   ),

                 ],
               ),
             )
         )
             // const SizedBox(
             //   height: 30,
             // ),




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

