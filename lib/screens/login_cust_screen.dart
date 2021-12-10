import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/home_cust_screen.dart';
import 'package:renthub_app/screens/home_rent_screen.dart';
import 'package:renthub_app/screens/login_screen.dart';
import 'package:renthub_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCustScreen extends StatefulWidget {
  static const String routeId = 'login_cust_screen';

  @override
  _LoginCustScreenState createState() => _LoginCustScreenState();
}

class _LoginCustScreenState extends State<LoginCustScreen> {
  final _auth = FirebaseAuth.instance;
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _hiddenText = true;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
            TextField(
              controller: _email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _password,
              obscureText: _hiddenText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                      _hiddenText ? Icons.visibility : Icons.visibility_off),
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
              child: Text('Login'),
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

                  await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushReplacementNamed(
                      context, HomeCustcreen.routeId);
                } catch (e) {
                  final snackbar = SnackBar(content: Text(e.toString()));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
            SizedBox(height:20),
            TextButton(
              child: Text('Belum punya akun? register disini'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
            ),
             TextButton(
              child: Text('Login sebagai toko? klik disini'),
              onPressed: () {
                 Navigator.pushReplacementNamed(context, LoginScreen.routeId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
