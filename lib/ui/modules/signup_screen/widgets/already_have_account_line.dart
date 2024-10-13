import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../login_screen/login_screen.dart';

class AlreadyHaveAccountLine extends StatelessWidget {
  const AlreadyHaveAccountLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.h,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, LoginScreen.routeName);
          },
          child: Text(
            'Already have an account?',
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium!
                .copyWith(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
