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
        padding: const EdgeInsets.only(left: 20, top: 50,right: 20),


        child:Column(

         crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
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
                          Icon(Icons.search),
                          Text("SEARCH")
                        ],
                      )
                  )
              )

            ],
          ),
          const SizedBox(height: 30),
          Text("DASHBOARD",style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 20),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
                Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                shadowColor: Colors.black,
                color: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(Icons.person),
                      Text("5"),
                      Text("Tenants")
                    ],
                  ),
                )
              ),
              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Colors.black,
                  color: Colors.deepOrange.shade500,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: const [
                        Icon(Icons.person),
                        Text("5"),
                        Text("Tenants")
                      ],
                    ),
                  )
              ),

              Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  shadowColor: Colors.black,
                  color: Colors.grey.shade300,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: const [
                        Icon(Icons.person),
                        Text("5"),
                        Text("Tenants")
                      ],
                    ),
                  )
              )


            ],
          )),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey)
            ),
            padding: EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                const Text("Tenants"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("DETAILS"),
                    Text("ACTIONS")

                  ],
                ),
                SizedBox(height: 20),
                Container(
                  color: Colors.deepOrange.shade50,
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(

                          children: [
                            Icon(Icons.account_box,size: 50,),
                            Column(
                              children: const [
                                Text("Emmilly"),
                                Text("Room 34")
                              ],
                            ),
                          ],
                        ),

                        TextButton(onPressed: onPressed, child: Text("Edit"),
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
                              backgroundColor:MaterialStateProperty.all<Color>(Colors.deepOrange.shade50) ,

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side:  BorderSide(color: Colors.deepOrange.shade200),

                                  )
                              )
                          ),)
                      ],
                    )
                )


              ]

            ),
          )
        ],

      ))
    );
  }


  void onPressed() {}
}
