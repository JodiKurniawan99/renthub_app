import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/data/model/cust_model.dart';
import 'package:renthub_app/screens/login_screen.dart';

class ProfileCustScreen extends StatefulWidget {
  @override
  _ProfileCustScreen createState() => _ProfileCustScreen();
}

class _ProfileCustScreen extends State<ProfileCustScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  CustModel _user = CustModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      _user = CustModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          toolbarHeight: 70,
          title: Text("Informasi Akun"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Theme.of(context).primaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 85.0,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(_user.urlPhotos ??
                                'https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg'),

                            /// Photo by @studiogstock via Freepik
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      "${_user.email}",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  Divider(color: Colors.black),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Nama',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      height: 30,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${_user.name}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Nomor Telepon',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 35.0),
                    child: SizedBox(
                      height: 30,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${_user.tlp}',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      height: 30,
                      child: MaterialButton(
                          child: Text('Logout'),
                          color: Theme.of(context).primaryColor,
                          textTheme: ButtonTextTheme.primary,
                          height: 40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeId);
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
