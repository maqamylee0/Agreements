import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/dashboard/home/addTenant/models/tenant.dart';
import 'package:tenant_bureau/rating/model/rate_model.dart';
import 'package:tenant_bureau/search/pages/widgets/rated_widget.dart';

import '../../services/auth.dart';

class SearchTenant extends StatefulWidget {
  const SearchTenant({Key? key}) : super(key: key);

  @override
  State<SearchTenant> createState() => _SearchTenantState();
}

class _SearchTenantState extends State<SearchTenant> {
  final searchController = TextEditingController();
  late List<RateModel> data;
  bool searched = false;

  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    // Map<dynamic, dynamic>? data2;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Search Tenant"),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  controller: searchController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password)=>
                  password != null  ?  null:"Enter a search term",
                  style: const TextStyle(),
                  decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: "search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),

              ),
              SizedBox(height: 10,),
              ElevatedButton(

                child: Text("Search",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20),),
                onPressed: ()  async {
                  // print("hiiiii ${searchController.text.toUpperCase()}");
                  data = await  auth.getAllTenantRates(searchController.text.toUpperCase());

                    setState(()  {
                        searched = true;
                           });
                   // data2 = data as Map;
                  if (kDebugMode) {
                    // print(data!['nin']);
                    // print()

                  }
                  // auth.signIn(context, emailController.text, passwordController.text)
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

              Expanded(
                child: Container(
                  child: searched ? Container(
                    // padding: EdgeInsets.all(30),
                      height: MediaQuery.of(context).size.height*0.6,
                      child: ListView.builder(

                          physics: ScrollPhysics(),
                          // shrinkWrap: true,
                          itemCount:data.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){

                            return Rated(rate : data[index]);
                          })
                  )
                   : Text("Search a tenant by entering their nin"),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
