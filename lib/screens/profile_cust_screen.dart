import 'package:flutter/material.dart';
import 'package:renthub_app/screens/login_screen.dart';

class ProfileCustScreen extends StatefulWidget {
  @override
  _ProfileCustScreen createState() => _ProfileCustScreen();
}

class _ProfileCustScreen extends State<ProfileCustScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: customerProfile());
  }

  Widget customerProfile() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
          child: Stack(
            children: const <Widget>[
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80"),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 35),
          child: Text(
            "jamesst01",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Name',
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
                      'James Styles',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Phone Number',
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
                      '0856-5455-4141',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Address',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50.0),
                child: SizedBox(
                  height: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Rainbow Street No. 45',
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
        )
      ],
    );
  }
}
