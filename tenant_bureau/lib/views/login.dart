import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenant_bureau/dashboard/home/newhome.dart';
import 'package:tenant_bureau/views/home.dart';
import 'package:tenant_bureau/views/register.dart';
// import '../dashboard/home/home.dart';
import '../dashboard/home/home.dart';
import '../services/auth.dart';
import '../utils.dart';
// import 'Utils.dart';
// import '../main.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);


  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  var name;
  @override
  void initState()  {
    super.initState();
     getUserName();

  }
  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot){
          if(snapshot.hasData){

            return  Home();
          }else{
            return const Log();
          }});
  }

  Future<String> getUserName() async {
    Auth auth = Auth();
    setState(() async {
      name = await auth.getUserName();

    });
    return name;
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
  Auth auth = Auth();
  var _passwordVisible;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();


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
      //       image: AssetImage('assets/background.png'), fit: BoxFit.cover),
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
            padding: const EdgeInsets.all(60),
            child:  Text(
              'Welcome\nBack',
              style: TextStyle(color: Statics.thirdColor, fontSize: 30,fontWeight: FontWeight.bold),
            ),
          ),
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
                  obscureText: !_passwordVisible, //
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      // Here is key idea
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
                    ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(

                  child: Text("Login",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                  onPressed: () => {
                      auth.signIn(context, emailController.text, passwordController.text)
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


// Future signIn(context,TextEditingController emailController,TextEditingController passwordController) async {
//   final isValid = formKey.currentState!.validate();
//   if(!isValid) return;
//   showDialog(context: context,barrierDismissible: false,
//       builder: (context) => const Center(child: CircularProgressIndicator()));
//   try{
//   await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
//   } on FirebaseException catch(e){
//     if (kDebugMode) {
//       print(e);
//     }
//     Utils.showSnackBar(e.message);
//
//   }
//
//   navigatorKey.currentState!.popUntil((route)=>route.isFirst);
// }
}