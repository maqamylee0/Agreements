import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/background.png'), fit: BoxFit.cover),
    ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Column(
                children: [
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
              child: const Text("GET TENANT HISTORY RECORDS FROM PREVIOUS LANDLORDS",style: TextStyle(fontSize: 30),),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child:ElevatedButton(

                child: Text("GET STARTED"),
                onPressed: () => print("it's pressed"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  primary: Colors.brown,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            )



                ])));
  }

  onPressed() {}
}
