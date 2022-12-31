import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../search/pages/search_tenant.dart';
import 'addTenant/add_tenant.dart';

class NewHome extends StatefulWidget {
  const NewHome({Key? key, }) : super(key: key);

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  var timeNow;
  var message = '';
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
  timeNow =  int.parse(DateFormat('kk').format(now));
  if(timeNow <= 12){
    message = "Good Morining Dear,\n ";
  } else if((timeNow > 12) && (timeNow <= 16)) {
    message = "Good Afternoon,\n ";
  }else if ((timeNow > 16) && (timeNow < 20)){
    message = "Good Evevning,\n ";
    } else {
   message = "Good Night, \n ";
    }
  }
  Stream<String> getUserName () async* {
    var prefs = await SharedPreferences.getInstance();
    var name = await prefs.getString('username');
    yield name!;

  }




  @override
  Widget build(BuildContext context) {
    var totalheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.brown,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          StreamBuilder<String>(
            stream: getUserName(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.active
                  || snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text("${message + snapshot.data.toString().toUpperCase()}",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 26),),
                  );

                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text("$message",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600,fontSize: 26),),
              );
            }
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
                          onPressed:(){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const SearchTenant()));
                          },
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
