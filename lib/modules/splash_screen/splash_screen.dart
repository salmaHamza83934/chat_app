import 'dart:async';

import 'package:chat_app/modules/login_screen/login_screen.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  static const String routeName='/';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
