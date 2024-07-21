import 'package:chat_app/modules/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/custom_txt_form_field.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isVisible=false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 320.h,),
                    Text(
                      'Welcome back!',
                      style: theme.textTheme.titleLarge!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 20.h,),
                    CustomTextFormField(
                      label: 'Enter your E-mail',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Enter your email';
                        }
                        bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h,),
                    CustomTextFormField(
                        suffix: isVisible?Icons.visibility:Icons.visibility_off,
                        pressed: (){
                          isVisible=!isVisible;
                          setState(() {

                          });
                        },
                        label: 'Enter your Password',
                        obscuretxt: !isVisible,
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Enter your Password';
                          }
                          return null;
                        }),
                    SizedBox(height: 70.h,),
                    Container(
                      height: 60.h,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      color: Color(0xFF3597DA),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Log In',style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),),
                          Icon(Icons.arrow_forward,color: Colors.white,)
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      },
                      child: Text(
                        'or Create account.',
                        textAlign: TextAlign.start,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Image.asset(
          'assets/images/background2.png',
          fit: BoxFit.cover,
          width: mediaQuery.width,
        ),
        Padding(
          padding: const EdgeInsets.all(50),
          child: Align(
            child: Text(
              'Log In',
              style: theme.textTheme.titleLarge!.copyWith(fontSize: 25),
            ),
            alignment: Alignment.topCenter,
          ),
        ),
      ]),
    );
  }
}

// if (formKey.currentState!.validate()) {
//   FirebaseManager.login(
//       emailController.text, passwordController.text,
//           () {
//         Navigator.pushNamedAndRemoveUntil(context,
//             HomeScreen.routeName, (Route) => false);
//       }, (message) {
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) => AlertDialog(
//         content: Text(
//           'Invalid Email or Password !',
//           style: theme.textTheme.bodyMedium!
//               .copyWith(fontSize: 15),
//           textAlign: TextAlign.center,
//         ),
//         actions: [
//           Center(
//             child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('Try again')),
//           )
//         ],
//       ),
//     );
//   });
// }