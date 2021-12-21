import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:renthub_app/screens/login_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);
  static const routeId = '/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(3.0, 0.0),
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.elasticIn,
  ));

  launchApp() async {
    var time = const Duration(milliseconds: 2300);
    return Timer(time, toHomeScreen);
  }

  @override
  void initState() {
    super.initState();
    launchApp();
  }

  void toHomeScreen() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: SlideTransition(
          position: _offsetAnimation,
          child: Icon(
            Icons.checkroom_rounded,
            color: Colors.white,
            size: 60,
          ),
        )),
      ),
    );
  }
}
