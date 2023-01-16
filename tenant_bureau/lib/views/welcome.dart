
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'login.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            backgroundColor: Colors.transparent,

            body:SafeArea(
              child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background.png'), fit: BoxFit.cover),
                  ),



                 child: Column(
                  children: [
                    SizedBox(height: 70,),
              Container(
              // padding: const EdgeInsets.only(left: 35, top: 30),
              child:Container(
              padding: EdgeInsets.fromLTRB(100, 0, 30, 0),
              child:LimitedBox(
                child: SvgPicture.asset("assets/icons/agreement.svg",  width: 200, height: 200,),
                maxHeight: 250,
                maxWidth: 300,
              )),

    ),
              // SizedBox(
              //   height: 50,
              // ),
              Container(
                padding: EdgeInsets.all(30),
                child: const Text("Get Tenant history records from previous Landlords",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(30),
                child:ElevatedButton(

                  child: Text("Get Started",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
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
              )



                  ])),
            ));
  }


}
