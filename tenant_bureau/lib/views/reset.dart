
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/views/register.dart';
import '../utils.dart';
import 'Utils.dart';
import 'login.dart';
import '../main.dart';

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
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      // ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 35, top: 130),
                      child: Text(
                        'Reset\nPassword',
                        style: TextStyle(color: Statics.thirdColor, fontSize: 33),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
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
                              ElevatedButton(

                                child: Text("Reset Password",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                                onPressed: () => {
                                  // Navigator.push(context,
                                      // MaterialPageRoute(builder: (context) => const Log()))
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size.fromHeight(60),
                                  primary: Statics.thirdColor,
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              // TextFormField(
                              //   controller: emailController,
                              //   autovalidateMode: AutovalidateMode.onUserInteraction,
                              //   validator: (password)=>
                              //   password != null && password.length > 6  ? "Enter a minimum of 6 characters": null,
                              //   style: TextStyle(),
                              //   obscureText: true,
                              //   decoration: InputDecoration(
                              //       fillColor: Colors.grey.shade100,
                              //       filled: true,
                              //       hintText: "Password",
                              //       border: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(10),
                              //       )),
                              // ),
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
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseException catch(e){
      print(e);
      Utils.showSnackBar(e.message);

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