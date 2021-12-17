import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/data/model/cust_model.dart';
import 'package:renthub_app/screens/login_screen.dart';
import 'package:renthub_app/screens/home_cust_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;


  bool _hiddenText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _isLoading? Center(child: CircularProgressIndicator()):
                Container(),
                SizedBox(height: 100.0),
                Text('REGISTRATION',
                    textAlign: TextAlign.center,
                    style:
                TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold)),
                SizedBox(height: 50.0),
                TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.people),
                    hintText: 'Nama',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.alternate_email),
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _password,
                  obscureText: _hiddenText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 24.0),
                MaterialButton(
                    child: Text('Register'),
                    color: Theme.of(context).primaryColor,
                    textTheme: ButtonTextTheme.primary,
                    height: 40,
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
                      final password = _password.text;

                      UserCredential result = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);

                      CustModel _user = CustModel(
                        name: name, 
                        email: email, 
                        userid: result.user!.uid,
                        role: 'customer'
                      );

                      await _firebaseFirestore
                          .collection("Users")
                          .doc(_user.userid)
                          .set({
                        'name': _user.name.trim(),
                        'email': _user.email.trim(),
                        'role': _user.role
                  
                      });
                      
                      Navigator.pop(context);
                    } catch (e) {
                      final snackbar = SnackBar(content: Text(e.toString()));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    } finally {
                      setState(() {
                      _isLoading = false;
                    });
                    }
                },),
                   
                TextButton(
                  child: Text('Already Registered? Login'),
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
