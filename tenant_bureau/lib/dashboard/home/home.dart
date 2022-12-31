import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tenant_bureau/dashboard/home/list_tenants/tenant_list.dart';

import '../../views/home.dart';
import 'Tenants.dart';
import 'newhome.dart';
import 'notifications.dart';

class Home extends StatefulWidget {
  const Home( {Key? key,}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;



  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: IndexedStack(
        children: [
          NewHome(),

          TenantList(),

          // Notifications()
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(()=>_currentIndex = index);
        },
        items:  [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house,color: Colors.brown,),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.rectangleList,color: Colors.brown,),
              label: "Tenants"
          ),
          // BottomNavigationBarItem(
          //     icon: FaIcon(FontAwesomeIcons.clock,color: Colors.brown,),
          //     label: "Notifications"
          // ),

        ],
      ),

    );  }
}
