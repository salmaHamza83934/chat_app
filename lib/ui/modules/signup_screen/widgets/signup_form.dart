import 'package:chat_app/ui/modules/login_screen/login_screen_view_model.dart';
import 'package:chat_app/ui/modules/signup_screen/signup_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/custom_txt_form_field.dart';

class SignupForm extends StatefulWidget {
  SignupScreenViewModel viewModel;

  SignupForm(this.viewModel);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 320.h,
        ),
        CustomTextFormField(
          label: 'Enter your Username',
          keyboardType: TextInputType.emailAddress,
          controller: widget.viewModel.usernameController,
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
          controller: widget.viewModel.emailController,
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
            suffix: widget.viewModel.isVisible?Icons.visibility:Icons.visibility_off,
            pressed: (){
              widget.viewModel.isVisible=!widget.viewModel.isVisible;
              setState(() {

              });
            },
            label: 'Enter your Password',
            obscuretxt: !widget.viewModel.isVisible,
            controller: widget.viewModel.passwordController,
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return 'Enter your Password';
              }
              return null;
            }),
        SizedBox(height: 20.h,),
        CustomTextFormField(
            suffix: widget.viewModel.isVisible?Icons.visibility:Icons.visibility_off,
            pressed: (){
              widget.viewModel.isVisible=!widget.viewModel.isVisible;
              setState(() {

              });
            },
            label: 'Enter your Confirm Password',
            obscuretxt: !widget.viewModel.isVisible,
            controller:widget.viewModel.confirmPasswordController,
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return 'Enter your confirm password';
              }
              if(widget.viewModel.confirmPasswordController.text!=widget.viewModel.passwordController.text){
                return 'Password and confirm password do not match!';
              }
              return null;
            }),
      ],
    );
  }
}
