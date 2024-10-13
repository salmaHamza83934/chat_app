import 'package:chat_app/ui/modules/signup_screen/signup_screen_view_model.dart';
import 'package:chat_app/ui/modules/signup_screen/widgets/already_have_account_line.dart';
import 'package:chat_app/ui/modules/signup_screen/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chat_app/ui/modules/utils/utils.dart' as utils;
import 'package:provider/provider.dart';
import '../connector/connector.dart';
import '../login_screen/login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = 'signup_screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> implements Connector{

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
              key: viewModel.formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SignupForm(viewModel),
                      SizedBox(
                        height: 70.h,
                      ),
                      GestureDetector(
                        onTap: (){
                          if(viewModel.formKey.currentState!.validate()){
                            viewModel.register(viewModel.usernameController.text,viewModel.emailController.text, viewModel.confirmPasswordController.text);
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
                      AlreadyHaveAccountLine(),
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
