import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(),
              SizedBox(height: 100.0),
              Text('REGISTRATION',
                  style: TextStyle(
                      fontSize: 40.0,
                      color: Color(0xff151528),
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 50.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person, color: Color(0xff151528)),
                  hintText: 'Name',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.alternate_email, color: Color(0xff151528)),
                  hintText: 'Username',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: Color(0xff151528)),
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone, color: Color(0xff151528)),
                  hintText: 'Phone Number',
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home, color: Color(0xff151528)),
                  hintText: 'Address',
                ),
              ),
              SizedBox(height: 24.0),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xff151528)),
                  child: Center(
                    child: Text('Register',
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
