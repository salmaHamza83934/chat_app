import 'dart:async';
import 'package:chat_app/ui/modules/login_screen/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/ui/modules/utils/utils.dart' as utils;
import '../connector/connector.dart';
import '../home_screen/home_screen.dart';
import '../signup_screen/signup_screen.dart';
import 'login_screen_view_model.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements Connector {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginScreenViewModel viewModel = LoginScreenViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.connector = this;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        key: _scaffoldKey,
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
                      LoginForm(viewModel),
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
            'assets/images/background@3x.png',
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
    utils.showMessage(context, message, 'OK', (context) {
      Navigator.pop(context);
      Future.delayed((Duration(seconds: 3)), () {
        Navigator.pushReplacementNamed(
            _scaffoldKey.currentContext!, HomeScreen.routeName);
      });
    });
  }
}
