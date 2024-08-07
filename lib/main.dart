import 'package:chat_app/core/theme.dart';
import 'package:chat_app/modules/home_screen/add_room_screen.dart';
import 'package:chat_app/modules/home_screen/chat_screen.dart';
import 'package:chat_app/modules/home_screen/home_screen.dart';
import 'package:chat_app/modules/login_screen/login_screen.dart';
import 'package:chat_app/modules/splash_screen/splash_screen.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'modules/signup_screen/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: AppTheme.mainTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              LoginScreen.routeName: (context) => LoginScreen(),
              SignupScreen.routeName: (context) => SignupScreen(),
              HomeScreen.routeName: (context) => HomeScreen(),
              AddRoomScreen.routeName:(context)=>AddRoomScreen(),
              ChatScreen.routeName:(context)=>ChatScreen()
            },
          );
        });
  }
}
