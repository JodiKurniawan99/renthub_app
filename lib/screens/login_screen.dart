import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:renthub_app/screens/home_cust_screen.dart';
import 'package:renthub_app/screens/home_rent_screen.dart';
import 'package:renthub_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String routeId = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _hiddenText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Container(),
                    SizedBox(height: 200.0),
                    Text('Selamat datang kembali!',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline6,
                        
                    ),
                    SizedBox(height: 10.0),
                    Text('Login ke akun anda',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1
                    ),
                    SizedBox(height: 33.0),
                    TextField(
                      controller: _email,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        focusColor: Color(0xFFf2f2f2),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.alternate_email, color: Colors.black),
                        hintText: 'Email',
                        filled: true,
                        
                        
                      ),
                      
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _password,
                      obscureText: _hiddenText,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 2, color: Colors.black),
                        ),
                        focusColor: Color(0xFFf2f2f2),
                        filled: true,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(_hiddenText
                              ? Icons.visibility
                              : Icons.visibility_off, color: Colors.black,),
                          onPressed: () {
                            setState(() {
                              _hiddenText = !_hiddenText;
                            });
                          },
                        ),
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 33.0),
                    MaterialButton(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          
                        ),
                        ),
                      color: Theme.of(context).primaryColor,
                      textTheme: ButtonTextTheme.primary,
                      height: 45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          final email = _email.text;
                          final password = _password.text;

                          UserCredential result =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          String uid = result.user!.uid;

                          var userDoc =
                              FirebaseFirestore.instance.collection('Users');
                          var snapshot = await userDoc.doc(uid).get();
                          if (snapshot.exists) {
                            Map<String, dynamic>? data = snapshot.data();
                            var value = data?['role'];
                            if (value != 'customer') {
                              Navigator.pushReplacementNamed(
                                  context, HomeRentScreen.routeId);
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeCustcreen()));
                            }
                          }
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Login failed!'),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                actions: <Widget>[
                                  MaterialButton(
                                    child: Text('Tutup'),
                                    color: Theme.of(context).primaryColor,
                                    textTheme: ButtonTextTheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
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
                    SizedBox(height: 33.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Tidak punya akun? "),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              'Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                 
                                  ),
                            ))
                      ],
                    ),
                    SizedBox(height: 50.0),
                  ],
                ),
              ),
            )));
  }
}
