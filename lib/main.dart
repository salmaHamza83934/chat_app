import 'package:chat_app/core/theme.dart';
import 'package:chat_app/ui/modules/home_screen/add_room_screen.dart';
import 'package:chat_app/ui/modules/home_screen/chat_screen.dart';
import 'package:chat_app/ui/modules/home_screen/home_screen.dart';
import 'package:chat_app/ui/modules/login_screen/login_screen.dart';
import 'package:chat_app/ui/modules/providers/user_provider.dart';
import 'package:chat_app/ui/modules/signup_screen/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const MyApp()));
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
          final UserProvider provider = context.read<UserProvider>(); // Access provider here
          return MaterialApp(
            theme: AppTheme.mainTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: provider.firebaseUser==null?LoginScreen.routeName:HomeScreen.routeName,
            routes: {
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
