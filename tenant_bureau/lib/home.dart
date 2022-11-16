import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
        padding: const EdgeInsets.only(left: 35, top: 50),


        child:Column(


        children: [
          Row(
            children: [
              SizedBox(
                height: 50,
                child:
                  TextButton(


                      onPressed:(){onPressed();},
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                          backgroundColor:MaterialStateProperty.all<Color>(Colors.deepOrange.shade50) ,

                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side:  BorderSide(color: Colors.deepOrange.shade200),

                              )
                          )
                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(Icons.add),
                          Text("ADD NEW")
                        ],
                      )
                  )
              )

            ],
          )
        ],

      ))
    );
  }


  void onPressed() {}
}
