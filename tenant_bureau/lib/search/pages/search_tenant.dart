import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/dashboard/home/addTenant/models/tenant.dart';

import '../../services/auth.dart';

class SearchTenant extends StatefulWidget {
  const SearchTenant({Key? key}) : super(key: key);

  @override
  State<SearchTenant> createState() => _SearchTenantState();
}

class _SearchTenantState extends State<SearchTenant> {
  final searchController = TextEditingController();
  late Map<dynamic, dynamic> data;
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
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: 50,),
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



setState(() async {
  data = await  auth.getTenant(context ,searchController.text);
  searched = true;
});
                 // data2 = data as Map;
                if (kDebugMode) {
                  print(data!['nin']);
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
                child: searched ? Text("${data['nin']}") : Text("hi"),
              ),

            )
          ],
        ),
      ),
    );
  }
}
