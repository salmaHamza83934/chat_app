import 'dart:async';

import 'package:chat_app/modules/home_screen/home_screen.dart';
import 'package:chat_app/modules/login_screen/login_screen.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../signup_screen/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    Timer(Duration(seconds: 3), () {
      provider.firebaseUser == null
          ? Navigator.pushReplacementNamed(context, LoginScreen.routeName)
          : Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: Scaffold(
        body: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),

      ),
    );
  }
}
