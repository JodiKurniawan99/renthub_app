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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () {
                  
                },
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.info_outline_rounded),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Tentang toko"),
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
            Container(
              color: Color(0xFFf2f2f2),
              height: 15
            ),
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
