import 'package:chat_app/modules/connector/connector.dart';
import 'package:chat_app/modules/login_screen/login_screen.dart';
import 'package:chat_app/modules/signup_screen/signup_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/utils/utils.dart' as utils;
import 'package:provider/provider.dart';
import '../../components/custom_txt_form_field.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = 'signup_screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> implements Connector{
  var usernameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPasswordController = TextEditingController();

  bool isVisible=false;

  var formKey = GlobalKey<FormState>();
  SignupScreenViewModel viewModel=SignupScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.connector=this;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context)=> viewModel,
      child: Scaffold(
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 320.h,
                      ),
                      CustomTextFormField(
                        label: 'Enter your Username',
                        keyboardType: TextInputType.emailAddress,
                        controller: usernameController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
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
                      SizedBox(
                        height: 20.h,
                      ),
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
                      SizedBox(height: 20.h,),
                      CustomTextFormField(
                          suffix: isVisible?Icons.visibility:Icons.visibility_off,
                          pressed: (){
                            isVisible=!isVisible;
                            setState(() {

                            });
                          },
                          label: 'Enter your Confirm Password',
                          obscuretxt: !isVisible,
                          controller: confirmPasswordController,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Enter your confirm password';
                            }
                            if(confirmPasswordController.text!=passwordController.text){
                              return 'Password and confirm password do not match!';
                            }
                            return null;
                          }),

                      SizedBox(
                        height: 70.h,
                      ),
                      GestureDetector(
                        onTap: (){
                          if(formKey.currentState!.validate()){
                            viewModel.register(usernameController.text,emailController.text, confirmPasswordController.text);
                          }
                        },
                        child: Container(
                          height: 60.h,
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          color: Color(0xFF3597DA),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Create Account',
                                style: theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
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
            'assets/images/background@3x.png',
            fit: BoxFit.cover,
            width: mediaQuery.width,
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: Align(
              child: Text(
                'Create Account',
                style: theme.textTheme.titleLarge!.copyWith(fontSize: 25),
              ),
              alignment: Alignment.topCenter,
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void hideLoading() {
    utils.hideLoading(context);
  }

  @override
  void showLoading() {
    utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context, message, 'OK', (context){Navigator.pushReplacementNamed(context, LoginScreen.routeName);});
  }
}
