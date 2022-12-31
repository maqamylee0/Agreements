import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenant_bureau/dashboard/home/addTenant/models/tenant.dart';

import 'bottom_sheet.dart';

class TenantButton extends StatefulWidget {
  const TenantButton({Key? key, required this.tenant}) : super(key: key);
 final TenantModel tenant;
  @override
  State<TenantButton> createState() => _TenantButtonState();
}

class _TenantButtonState extends State<TenantButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(


      style: ButtonStyle(

        // minimumSize: MaterialStateProperty.all(Size(150, 20)),
        // padding:  MaterialStateProperty.all(EdgeInsets.fromLTRB(12, 5, 12, 5)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),

        shape: MaterialStateProperty.all<RoundedRectangleBorder>(

          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),

          ),

        ),
        // side: MaterialStateBorderSide.resolveWith((Set<MaterialState> states) {
        //   {
        //     return const BorderSide(color: Colors.grey);
        //   }
        //   return null; // Defer to default value on the theme or widget.
        // }),
        // shadowColor:MaterialStateProperty.all<Color>(Color.fromRGBO(8, 143, 129, 0.4)) ,
        // elevation: MaterialStateProperty.all<double>(20),
      ),
      onPressed: () {
        showBottomSheet(context: context, builder: (BuildContext context){
        return BottomRate(tenant:widget.tenant);
        });
      },
      child: Text('Rate Tenant',style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.w600),),

    );
  }
}
