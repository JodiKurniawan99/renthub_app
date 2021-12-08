import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:renthub_app/screens/login_screen.dart';

class HomeRentScreen extends StatefulWidget{
  static const String routeId = 'home_rent_screen';
  @override
  _HomeRentScreenState createState() => _HomeRentScreenState();

}
class _HomeRentScreenState extends State<HomeRentScreen>{
  int currScreen = 0;
  GlobalKey bottomNavKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Renthub"),
      ),
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
          TabData(iconData: Icons.notes, 
              title: "Pesanan",
          ),
          TabData(
            iconData: Icons.account_circle,
            title: "Akun",
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
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: InkWell(
                  splashColor: Colors.blueAccent.withAlpha(20),
                  onTap: () {},
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text("Pesanan baru"),
                      Text(
                        "0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: InkWell(
                  splashColor: Colors.blueAccent.withAlpha(20),
                  onTap: () {},
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text("Barang yang sedang disewa"),
                      Text(
                        "0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                child: InkWell(
                  splashColor: Colors.blueAccent.withAlpha(20),
                  onTap: () {},
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text("Barang yang dikembalikan"),
                      Text(
                        "0",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
            )          
          ],
        );
      case 1:
        return Column();
      case 2:
        return Column();
      case 3:
        return Column();
       
    }
  }

}