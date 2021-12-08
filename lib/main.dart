import 'package:flutter/material.dart';
import 'package:renthub_app/screens/login_screen.dart';
import 'package:renthub_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Renthub App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashScreen.routeId,
      routes: {
        SplashScreen.routeId: (context) => SplashScreen(),
        LoginScreen.routeId: (context) => LoginScreen(),
      },
    );
  }
}
