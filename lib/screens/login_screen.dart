import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/home_rent_screen.dart';
import 'package:renthub_app/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeId = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility_off),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, HomeRentScreen.routeId);
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
                onPressed: () {}),
            TextButton(
              child: Text('Belum punya akun? register disini'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
                
              },
            ),
          ],
        ),
      ),
    );
  }
}
