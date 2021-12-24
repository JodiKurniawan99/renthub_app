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
          toolbarHeight: 60,
          title: Text("Informasi Akun"),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22),
                    bottomRight: Radius.circular(22)),
                color: Theme.of(context).primaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children:<Widget>[
                       Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 45.0,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(_user.urlPhotos ??
                                  'https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg'),

                              /// Photo by @studiogstock via Freepik
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "${_user.name}",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: SizedBox(
                          height: 30,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${_user.email}',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                    ]),

                    ]
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                   
                      child: Text(
                        'Kontak',
                        style:
                            Theme.of(context).textTheme.headline6,
                      ), 
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 35.0),
                    
                      
                        child: Text(
                          '${_user.tlp}',
                          style:Theme.of(context).textTheme.bodyText2,
                        ),
                      
                  
                  ),
                  Container(color: Color(0xFFf2f2f2), height: 15, ),
                  SizedBox(height: 20),
                  MaterialButton(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 16,
                          
                        ),
                        ),
                      color: Theme.of(context).primaryColor,
                      textTheme: ButtonTextTheme.primary,
                      height: 45,
                      minWidth: 350,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: (){
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacementNamed(context, LoginScreen.routeId);
                      }
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
