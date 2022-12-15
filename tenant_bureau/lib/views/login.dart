
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/views/home.dart';
import 'package:tenant_bureau/views/register.dart';
import 'Utils.dart';
import '../main.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);


  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot){
          if(snapshot.hasData){
            return const HomePage();
          }else{
            return const Log();
          }});
  }
}
class Log extends StatefulWidget {
  const Log({Key? key}) : super(key: key);

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();


    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(60),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold),
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
            margin: const EdgeInsets.only(left: 35, right: 35),
            child: Form(
              key: formKey,
              child:

            Column(
              children: [
                TextFormField(
                  controller:emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email)=>
                  email != null && EmailValidator.validate(email) ?  null:"Enter valid Email",
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: passwordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password)=>
                  password != null && password.length > 6  ?  null:"Enter a minimum of 6 characters",
                  style: const TextStyle(),
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(

                  child: Text("Login",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                  onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Log()))
                  },
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
                //     const Text(
                //       'Sign in',
                //       style: TextStyle(
                //           fontSize: 27, fontWeight: FontWeight.w700),
                //     ),
                //     CircleAvatar(
                //       radius: 30,
                //       backgroundColor: const Color(0xff4c505b),
                //       child: IconButton(
                //           color: Colors.white,
                //           onPressed: () {
                //             signIn(context,emailController,passwordController);
                //           },
                //           icon: const Icon(
                //             Icons.arrow_forward,
                //           )),
                //     )
                //   ],
                // ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register');
                      },
                      style: const ButtonStyle(),
                      child: const Text(
                        'Sign Up',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xff4c505b),
                            fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'reset');
                      },
                      style: const ButtonStyle(),
                      child: const Text(
                        'Forgot Password',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xff4c505b),
                            fontSize: 18),
                      ),
                    ),
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
      builder: (context) => const Center(child: CircularProgressIndicator()));
  try{
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
  } on FirebaseException catch(e){
    if (kDebugMode) {
      print(e);
    }
    Utils.showSnackBar(e.message);

  }

  navigatorKey.currentState!.popUntil((route)=>route.isFirst);
}}