import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addTenant/add_tenant.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key}) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {

  @override
  Widget build(BuildContext context) {
    var totalheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.brown,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Text("DASHBOARD",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 30),),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            height: totalheight*0.2,
            color: Colors.brown,
            child: Container(
              // height: MediaQuery.of(context).size.height*0.1,
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 60,
                      width: 120,
                      child:
                      TextButton(

                          onPressed:(){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const AddTenant()));
                          },
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                              backgroundColor:MaterialStateProperty.all<Color>(Colors.brown.shade50) ,

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side:  BorderSide(color: Colors.brown.shade200),

                                  )
                              )
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [

                              Icon(Icons.add),
                              Text("ADD NEW",style: TextStyle(fontWeight: FontWeight.w600),)
                            ],
                          )
                      )
                  ),
                  SizedBox(
                      height: 60,
                      width: 120,
                      child:
                      TextButton(
                          onPressed:(){},
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.brown),
                              backgroundColor:MaterialStateProperty.all<Color>(Colors.brown.shade50) ,

                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                    side:  BorderSide(color: Colors.brown),

                                  )
                              )
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Icon(Icons.search),
                              Text("SEARCH",style: TextStyle(fontWeight: FontWeight.w600),)
                            ],
                          )
                      )
                  )

                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(30),
              height: double.maxFinite,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)
                  )

              ),
              child: Container(
                // height: MediaQuery.of(context).size.height*0.9,
                child:  GridView(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 30),
                    children: [
                      Container(

                        // padding: EdgeInsets.all(40),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              child: Column(
                                children: const [
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.account_box,size: 50,color: Colors.brown,),
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Tenants",style: TextStyle(fontWeight: FontWeight.bold)),
                                  )
                                ],

                              )
                          )
                      ),

                      Container(

                        // padding: EdgeInsets.all(40),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              child: Column(
                                children: const [
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.account_box,size: 50,color: Colors.brown),
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Agreements",style: TextStyle(fontWeight: FontWeight.bold)),
                                  )
                                ],

                              )
                          )
                      ),
                      Container(

                        // padding: EdgeInsets.all(40),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              child: Column(
                                children: const [
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.account_box,size: 50,color: Colors.brown),
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text("Pending",style: TextStyle(fontWeight: FontWeight.bold)),
                                  )
                                ],

                              )
                          )
                      ),
                      Container(

                        // padding: EdgeInsets.all(40),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 10,
                              child: Column(
                                children: const [
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:Icon(Icons.account_box,size: 50,color: Colors.brown),
                                  ),
                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Text("Sent",style: TextStyle(fontWeight: FontWeight.bold),),
                                  )
                                ],

                              )
                          )
                      ),
                    ]),
              ),
            ),
          )

        ],

      ),


      //
      // Column(
      //
      // child:
      //   Container(
      //
      //   padding: EdgeInsets.all(50),
      //   child: Column(
      //     children: [
      //       Container(
      //         height: MediaQuery.of(context).size.height*0.1,
      //         child: Row(
      //
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             SizedBox(
      //                 height: 50,
      //                 child:
      //                 TextButton(
      //                     onPressed:(){
      //                       Navigator.push(context,
      //                           MaterialPageRoute(builder: (context) => const AddTenant()));
      //                     },
      //                     style: ButtonStyle(
      //                         foregroundColor: MaterialStateProperty.all<Color>(Colors.brown),
      //                         backgroundColor:MaterialStateProperty.all<Color>(Colors.brown.shade50) ,
      //
      //                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //                             RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(16.0),
      //                               side:  BorderSide(color: Colors.brown.shade200),
      //
      //                             )
      //                         )
      //                     ),
      //
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                       children: const [
      //
      //                         Icon(Icons.add),
      //                         Text("ADD NEW")
      //                       ],
      //                     )
      //                 )
      //             ),
      //             SizedBox(
      //                 height: 50,
      //                 child:
      //                 TextButton(
      //                     onPressed:(){},
      //                     style: ButtonStyle(
      //                         foregroundColor: MaterialStateProperty.all<Color>(Colors.brown),
      //                         backgroundColor:MaterialStateProperty.all<Color>(Colors.brown.shade50) ,
      //
      //                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //                             RoundedRectangleBorder(
      //                               borderRadius: BorderRadius.circular(16.0),
      //                               side:  BorderSide(color: Colors.brown),
      //
      //                             )
      //                         )
      //                     ),
      //
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                       children: const [
      //                         Icon(Icons.search),
      //                         Text("SEARCH")
      //                       ],
      //                     )
      //                 )
      //             )
      //
      //           ],
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 200,
      //       ),
      //       Container(
      //         height: MediaQuery.of(context).size.height*0.9,
      //         child:  GridView(
      //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //                 crossAxisCount: 2,
      //                 crossAxisSpacing: 20,
      //                 mainAxisSpacing: 10),
      //             children: [
      //               Container(
      //
      //                   // padding: EdgeInsets.all(40),
      //                   child: Card(
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(20.0),
      //                       ),
      //                       elevation: 10,
      //                       child: Column(
      //                         children: const [
      //                           SizedBox(height: 5,),
      //                           Padding(
      //                             padding: EdgeInsets.all(8.0),
      //                             child: Icon(Icons.account_box,size: 50,),
      //                           ),
      //                           SizedBox(height: 20,),
      //                           Padding(
      //                             padding: EdgeInsets.all(8.0),
      //                             child: Text("Tenants",style: TextStyle(fontWeight: FontWeight.bold)),
      //                           )
      //                         ],
      //
      //                       )
      //                   )
      //               ),
      //
      //               Container(
      //
      //                   // padding: EdgeInsets.all(40),
      //                   child: Card(
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(20.0),
      //                       ),
      //                       elevation: 10,
      //                       child: Column(
      //                         children: const [
      //                           SizedBox(height: 5,),
      //                           Padding(
      //                             padding: EdgeInsets.all(8.0),
      //                             child: Icon(Icons.account_box,size: 50,),
      //                           ),
      //                           SizedBox(height: 20,),
      //                           Padding(
      //                             padding: EdgeInsets.all(8.0),
      //                             child: Text("Agreements",style: TextStyle(fontWeight: FontWeight.bold)),
      //                           )
      //                         ],
      //
      //                       )
      //                   )
      //               ),
      //               Container(
      //
      //                   // padding: EdgeInsets.all(40),
      //                   child: Card(
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(20.0),
      //                       ),
      //                       elevation: 10,
      //                       child: Column(
      //                         children: const [
      //                           SizedBox(height: 5,),
      //                           Padding(
      //                             padding: EdgeInsets.all(8.0),
      //                             child: Icon(Icons.account_box,size: 50,),
      //                           ),
      //                           SizedBox(height: 20,),
      //                           Padding(
      //                             padding: EdgeInsets.all(3.0),
      //                             child: Text("Pending",style: TextStyle(fontWeight: FontWeight.bold)),
      //                           )
      //                         ],
      //
      //                       )
      //                   )
      //               ),
      //               Container(
      //
      //                   // padding: EdgeInsets.all(40),
      //                   child: Card(
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(20.0),
      //                       ),
      //                       elevation: 10,
      //                       child: Column(
      //                         children: const [
      //                           SizedBox(height: 5,),
      //                           Padding(
      //                             padding: EdgeInsets.all(8.0),
      //                             child:Icon(Icons.account_box,size: 50,),
      //                           ),
      //                           SizedBox(height: 20,),
      //                           Padding(
      //                             padding: EdgeInsets.all(3.0),
      //                             child: Text("Sent",style: TextStyle(fontWeight: FontWeight.bold),),
      //                           )
      //                         ],
      //
      //                       )
      //                   )
      //               ),
      //             ]),
      //       )
      //     ],
      //   ),
      // )),
    );
  }
}
