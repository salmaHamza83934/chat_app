import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../login_screen/login_screen.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return         Padding(
      padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: Colors.transparent,
            size: 35.r,
          ),
          Spacer(),
          Text(
            'Chat App',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 25),
          ),
          Spacer(),
          GestureDetector(
              onTap: () async{
                await FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                }).catchError((onError){debugPrint(onError.toString());});
              },
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
                size: 35.r,
              ))
        ],
      ),
    );
  }
}
