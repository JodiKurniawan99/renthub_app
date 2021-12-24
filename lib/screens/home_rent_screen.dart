import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:renthub_app/screens/home_first_screen.dart';
import 'package:renthub_app/screens/home_profile_screen.dart';
import 'package:renthub_app/screens/list_cust_order.dart';
import 'package:renthub_app/screens/list_order_screen.dart';
import 'package:renthub_app/screens/list_rent_screen.dart';
import 'package:renthub_app/screens/login_screen.dart';

class HomeRentScreen extends StatefulWidget{
  static const String routeId = 'home_rent_screen';
  @override
  _HomeRentScreenState createState() => _HomeRentScreenState();

}
class _HomeRentScreenState extends State<HomeRentScreen>{
  int currScreen = 0;
  GlobalKey bottomNavKey = GlobalKey();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      
      body: Container(
        child: Center(
          child: _getScreen(currScreen),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
              iconData: Icons.home,
              title: "Beranda",
          ),
          TabData(
              iconData: Icons.burst_mode_rounded,
              title: "Produk",
          ),
          TabData(
            iconData: Icons.account_circle,
            title: "Akun",
          )
        ],
        initialSelection: 0,
        key: bottomNavKey,
        onTabChangedListener: (position) {
          setState(() {
            currScreen = position;
          });
        },
      ),
    );
  }

  _getScreen(int index) {
    switch (index) {
      case 0:
        return HomeFirstScreen();
      case 1:
        return ListRentScreen();
      case 2:
        return HomeProfileScreen();  
    }
  }

}