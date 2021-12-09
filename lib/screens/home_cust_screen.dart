import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/list_clothes_screen.dart';
import 'package:renthub_app/screens/profile_cust_screen.dart';

class HomeCustcreen extends StatefulWidget {
  static const String routeId = 'home_cust_screen';
  @override
  _HomeCustcreen createState() => _HomeCustcreen();
}

class _HomeCustcreen extends State<HomeCustcreen> {
  int currScreen = 1;
  GlobalKey bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Renthub"),
      ),
      body: Center(
        child: _getScreen(currScreen),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: Icons.history,
            title: "Rent",
          ),
          TabData(
            iconData: Icons.home,
            title: "Home",
          ),
          TabData(
            iconData: Icons.account_circle,
            title: "Profile",
          )
        ],
        initialSelection: 1,
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
        return Column();
      case 1:
        return ListClothesScreen();
      case 2:
        return ProfileCustScreen();
    }
  }
}
