import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/dashboard/home/addTenant/models/tenant.dart';
import 'package:tenant_bureau/dashboard/home/list_tenants/widgets/tenant_button.dart';

class TenantCard extends StatefulWidget {
  const TenantCard({Key? key, required this.tenant}) : super(key: key);
  final TenantModel tenant;
  @override
  State<TenantCard> createState() => _TenantCardState();
}

class _TenantCardState extends State<TenantCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.tenant.previousLandLordPhone);
    return Container(
      child:Column(
      children: [
      Row(
      children: [
      Container(
    decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage("assets/emily.jpg"), fit: BoxFit.cover),
    borderRadius: BorderRadius.circular(10)
    ),
    height: 105,
    width: 90,

    ),
    SizedBox(width: 10,),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Padding(
    padding: const EdgeInsets.fromLTRB(2, 10, 2, 2),
    child: Text("${widget.tenant.name}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
    ),
    Padding(
    padding: const EdgeInsets.all(1.0),
    child: Text('${widget.tenant.email}',style: TextStyle(color: Colors.grey),),
    ),
    SizedBox(height: 5,), TenantButton(tenant: widget.tenant,),


    ],
    )
    ],
    )
    ],
    ),

    );
  }
}
