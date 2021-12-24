import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/login_screen.dart';

class HomeProfileScreen extends StatelessWidget {
  static const routeId = '/home_profile_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Akun Saya")),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25.0)),
                      ),
                      builder: (builder) {
                        return new Container(
                          height: 350.0,
                              child:
                                Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical:48.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.0, left: 16.0),
                                    child: Text(
                                      "Nama toko",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.0, left: 16.0),
                                    child: Text(
                                      "Rentub",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.0, left: 16.0),
                                    child: Text(
                                      "Email toko",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.0, left: 16.0),
                                    child: Text(
                                      FirebaseAuth.instance.currentUser!.email!,
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.0, left: 16.0),
                                    child: Text(
                                      "Jam buka toko",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: 8.0, left: 16.0),
                                    child: Text(
                                      "09.00-21.00",
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                  ),
                                  ],
                                )),     
                        );
                      });
                },
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.account_circle),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Informasi toko"),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                    Icon(Icons.navigate_next_rounded)
                  ],
                )),
              ),
            ),
            SizedBox(height: 20),
            Container(color: Color(0xFFf2f2f2), height: 15),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, LoginScreen.routeId);
                },
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.logout),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Logout"),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                )),
              ),
            ),
          ],
        ));
  }
}
