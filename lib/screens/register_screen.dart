import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/login_screen.dart';
import 'package:renthub_app/screens/home_cust_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = FirebaseAuth.instance;

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
                      final email = _email.text;
                      final password = _password.text;
 
                      await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
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
