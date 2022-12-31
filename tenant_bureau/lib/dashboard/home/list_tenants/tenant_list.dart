import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenant_bureau/blocs/tenant_bloc/tenant_bloc.dart';
import 'package:tenant_bureau/dashboard/home/list_tenants/widgets/tenant_list_widget.dart';

import '../addTenant/models/tenant.dart';

class TenantList extends StatefulWidget {
  const TenantList({Key? key}) : super(key: key);

  @override
  State<TenantList> createState() => _TenantListState();
}

class _TenantListState extends State<TenantList> {
  final search2Controller = TextEditingController();
  List<TenantModel> results = [];
  late List<TenantModel> listOfTenants;
  @override
  void initState() {
    super.initState();

    //Trigger the load event
    context.read<TenantBloc>().add(LoadTenants());
  }
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = listOfTenants;
    } else {
      results = listOfTenants!
          .where((tenant) =>
          ((tenant.name!.toLowerCase()).contains(enteredKeyword.toLowerCase()) ))
          .toList();

      print("results are $results");
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      listOfTenants = results;
      print(" results are $results");
    });
  }
  @override
  Widget build(BuildContext context) {
    var tenantBloc = context.watch<TenantBloc>();
    listOfTenants = tenantBloc.state.listOfTenants;


    return Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          title: Text("Tenants"),
        ),
      body: listOfTenants.isEmpty ?
          Center(
            child:Text("No Tenants Yet")
          ):
      SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // SizedBox(
              //   height: 50,
              // ),

              Container(
                height: MediaQuery.of(context).size.height*0.1,
                child: TextField(
                  controller: search2Controller,
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  // validator: (password)=>
                  // password != null  ?  null:"Enter a search term",
                  onChanged:(value) => _runFilter(value),

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

              Expanded(
                // padding: EdgeInsets.all(30),
                // height: MediaQuery.of(context).size.height*0.6,
                  child: ListView.builder(

                      physics: ScrollPhysics(),
                      // shrinkWrap: true,
                      itemCount:search2Controller.text == '' ? listOfTenants.length : results.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context,index){

                        return TenantCard(tenant: search2Controller.text == '' ? listOfTenants[index] : results[index]);
                      })
              )
            ],

          ),
        ),
      ),
    );
  }
}
