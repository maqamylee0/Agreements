import 'dart:js';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/register.dart';
import 'Utils.dart';
import 'main.dart';

class MyReset extends StatefulWidget {
  const MyReset({Key? key}) : super(key: key);


  @override
  _MyResetState createState() => _MyResetState();
}

class _MyResetState extends State<MyReset> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot){
          if(snapshot.hasData){
            return Log();
          }else{
            return MyReset();
          }});
  }
}
class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final navigatorKey = GlobalKey<NavigatorState>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text(
                'Reset\nPassword',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 35, right: 35),
                        child: Form(
                          key: formKey,
                          child:

                          Column(
                            children: [
                              TextFormField(
                                controller:emailController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (email)=>
                                email != null && EmailValidator.validate(email) ? "Enter valid Email": null,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                controller: passwordController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (password)=>
                                password != null && password.length > 6  ? "Enter a minimum of 6 characters": null,
                                style: TextStyle(),
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              // SizedBox(
                              //   height: 40,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       'Sign in',
                              //       style: TextStyle(
                              //           fontSize: 27, fontWeight: FontWeight.w700),
                              //     ),
                              //     CircleAvatar(
                              //       radius: 30,
                              //       backgroundColor: Color(0xff4c505b),
                              //       child: IconButton(
                              //           color: Colors.white,
                              //           onPressed: () {
                              //             signIn(context,emailController,passwordController);
                              //           },
                              //           icon: Icon(
                              //             Icons.arrow_forward,
                              //           )),
                              //     )
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 40,
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  TextButton(
                                      onPressed: () {
                                        reset(context,emailController);
                                      },
                                      child: Text(
                                        'Rest Password',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18,
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),)
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future signIn(context,TextEditingController emailController,TextEditingController passwordController) async {
    final isValid = formKey.currentState!.validate();
    if(!isValid) return;
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseException catch(e){
      print(e);
      Utils.showSnackBar(e.message)

    }
    navigatorKey.currentState!.popUntil((route)=>route.isFirst);
  }

  Future reset( context,TextEditingController emailController) async  {
    showDialog(context: context,barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());
      Utils.showSnackBar("Password Reset Email Sent");
    }  on FirebaseAuthException catch (e){
      print(e);
      Utils.showSnackBar(e.message);

    }
    Navigator.of(context).pop();
  }
}