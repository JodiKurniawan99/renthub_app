import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/data/model/cust_model.dart';
import 'package:renthub_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _tlp = TextEditingController();
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  bool _hiddenText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
                SizedBox(height: 50.0),
                Text('RentHub',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 57,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5)),
                SizedBox(height: 5.0),
                Text('Create an Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 19,
                        letterSpacing: -0.5)),
                SizedBox(height: 45.0),
                TextField(
                  controller: _name,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Nama Lengkap',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _email,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email),
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _tlp,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                    hintText: 'Phone Number',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _password,
                  obscureText: _hiddenText,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_hiddenText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _hiddenText = !_hiddenText;
                        });
                      },
                    ),
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 24.0),
                MaterialButton(
                  child: Text('Sign Up'),
                  color: Theme.of(context).primaryColor,
                  textTheme: ButtonTextTheme.primary,
                  height: 45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final name = _name.text;
                      final email = _email.text;
                      final tlp = _tlp.text;
                      final password = _password.text;

                      UserCredential result =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      CustModel _user = CustModel(
                          name: name,
                          email: email,
                          userid: result.user!.uid,
                          role: 'customer',
                          tlp: tlp);

                      await _firebaseFirestore
                          .collection("Users")
                          .doc(_user.userid)
                          .set({
                        'name': _user.name.trim(),
                        'email': _user.email.trim(),
                        'role': _user.role,
                        'tlp': _user.tlp.trim()
                      });

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign up success!'),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Login'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Sign up failed!'),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0))),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Close'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                ),
                TextButton(
                  child: Text('Already sign up? Login'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
