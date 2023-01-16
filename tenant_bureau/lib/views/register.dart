import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_bureau/views/verifyEmail.dart';

import '../services/auth.dart';
import 'Utils.dart';
import 'login.dart';
import '../main.dart';
import '../models/User.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {


  @override
  Widget build(BuildContext context) {
    return Reg();
      // StreamBuilder<User?>(
      // stream: FirebaseAuth.instance.authStateChanges(),
      //   builder:(context, snapshot){
      //   if(snapshot.hasData){
      //     return const VerifyEmailPage(name: '${userModel.name}',);
      //   }else{
      //   return const Reg();
      //   }});
  }

}
class Reg extends StatefulWidget {
  const Reg({Key? key}) : super(key: key);

  @override
  State<Reg> createState() => _RegState();
}
class _RegState extends State<Reg> {

  final _auth = FirebaseAuth.instance;
  static late final User? user;
  Auth auth = Auth();

  bool showSpinner = false;
  String? errorMessage;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final ninController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var _passwordVisible;

  // @override
  // void initState(){
  //   super.initState();
  //   getIds();
  // }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    ninController.dispose();

    super.dispose();
  }
  @override
  void initState() {
    _passwordVisible = false;
  }
    @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/background.pn'), fit: BoxFit.cover),

      child: Scaffold(
        backgroundColor: Colors.white,

        body: Stack(
          children: [


            // Container(
            //   padding: EdgeInsets.fromLTRB(100, 0, 30, 0),
            //     child:LimitedBox(
            //       child: SvgPicture.asset("assets/icons/agreement.svg",  width: 200, height: 200,),
            //       maxHeight: 50,
            //       maxWidth: 300,
            //     )),
            SingleChildScrollView(

              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(60),
                        child: const Text(
                          'Create \n account',
                          style: TextStyle(color: Colors.brown, fontSize: 30,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextFormField(
                              controller : nameController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value)=>
                              value == null ? "Enter a name": null,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Name",
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(

                              controller : emailController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (email)=>
                              email != null && EmailValidator.validate(email) ?  null:"Enter valid Email",

                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Email",
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller : ninController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value)=>
                              value != null && value.length == 14 ? null: "Enter a valid NIN" ,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "NIN",
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            TextFormField(
                              controller : passwordController,

                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value)=>
                              value != null && value.length > 6 ? null: "Password must be more than 6 characters",
                              style: const TextStyle(color: Colors.black),
                              obscureText: !_passwordVisible, //
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),





                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(

                              child: Text("Sign Up",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                              onPressed: () {onPressed();},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(60),
                                primary: Colors.brown[700],
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //
                            //     const Text(
                            //       'Sign Up',
                            //       style: TextStyle(
                            //           color: Colors.white,
                            //           fontSize: 27,
                            //           fontWeight: FontWeight.w700),
                            //     ),
                            //
                            //     CircleAvatar(
                            //       radius: 30,
                            //       backgroundColor: const Color(0xff4c505b),
                            //       child: IconButton(
                            //           color: Colors.white,
                            //           onPressed: () {
                            //             signUp(emailController.text,passwordController.text);
                            //           },
                            //           icon: const Icon(
                            //             Icons.arrow_forward,
                            //           )),
                            //     )
                            //   ],
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'login');
                                    // Navigator.of(context).push(_createRoute());
                                  },
                                  style: const ButtonStyle(),
                                  child: const Text(
                                    'Sign In',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => const MyLogin(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return child;
//     },
//   );
// }
//   getIds() async {
//     // final directory = await getApplicationDocumentsDirectory();
//     // box1 = await Hive.openBox('personaldata');
//   }



  // Future signUp(context,TextEditingController emailController,TextEditingController passwordController) async {
  // // showDialog(context: context,barrierDismissible: false,
  // //     builder: (context) => Center(child: CircularProgressIndicator()));
  // try{
  //   await _auth.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
  // } on FirebaseException catch(e){
  //   if (kDebugMode) {
  //     print(e);
  //   }
  //   Utils.showSnackBar(e.message);
  // }
  // navigatorKey.currentState!.popUntil((route)=>route.isFirst);}}
// Future signUp(String email, String password) async {
//   // print("hyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
//
//   setState(() {
//     showSpinner = true;
//   });
//   // if (_formKey.currentState!.validate()) {
//   try {
//     await _auth
//         .createUserWithEmailAndPassword(email: email, password: password)
//         .then((value) => { postDetailsToFirestore()})
//         .catchError((e) {
//       Fluttertoast.showToast(msg: e!.message);
//     });
//   } on FirebaseAuthException catch (error) {
//     setState(() {
//       showSpinner = false;
//     });
//     switch (error.code) {
//       case "invalid-email":
//         errorMessage = "Your email address appears to be malformed.";
//         break;
//       case "wrong-password":
//         errorMessage = "Your password is wrong.";
//         break;
//       case "user-not-found":
//         errorMessage = "User with this email doesn't exist.";
//         break;
//       case "user-disabled":
//         errorMessage = "User with this email has been disabled.";
//         break;
//       case "too-many-requests":
//         errorMessage = "Too many requests";
//         break;
//       case "operation-not-allowed":
//         errorMessage = "Signing in with Email and Password is not enabled.";
//         break;
//       default:
//         errorMessage = "An undefined Error happened.";
//     }
//     setState(() {
//       showSpinner = false;
//     });
//     Fluttertoast.showToast(msg: errorMessage!);
//     print(error.code);
//   }
//   navigatorKey.currentState!.popUntil((route)=>route.isFirst);
// }
//   postDetailsToFirestore() async {
//     // print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
//
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     user = _auth.currentUser;
//     // box1.put('userid', user!.uid);
//     UserModel userModel = UserModel();
//     print(userModel);
//     // writing all the values
//     userModel.email = user!.email;
//     userModel.uid = user!.uid;
//     userModel.name = nameController.text;
//     userModel.nin = ninController.text;
//
//     // print(userModel.uid,);
//     // print(userModel.email);
//     // print(userModel.name);
//     // print(userModel.nin);
//
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userid', '${user!.uid}');
//
//     await firebaseFirestore
//         .collection("users")
//         .doc(user!.uid)
//         .set(userModel.toMap());
//     setState(() {
//       showSpinner = false;
//     });
//     Fluttertoast.showToast(msg: "Account created successfully :) ");
//     Navigator.push(context,
//         MaterialPageRoute(builder: (context) => const Log()));
//
//   }

  void onPressed() {
    final isValid = formKey.currentState!.validate();
    if (isValid){
      UserModel userModel = UserModel();
      // writing all the values

      userModel.name = nameController.text;
      userModel.nin = ninController.text;
      print(userModel);

      auth.signUp(emailController.text, passwordController.text,userModel,context);
      errorMessage = auth.errorMessage;
    }else{
      Fluttertoast.showToast(msg: "Please Fill All Details");
    }
  }
}