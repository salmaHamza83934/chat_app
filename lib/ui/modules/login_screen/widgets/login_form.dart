import 'package:chat_app/ui/modules/login_screen/login_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/custom_txt_form_field.dart';

class LoginForm extends StatefulWidget {
  LoginScreenViewModel viewModel;


  LoginForm(this.viewModel);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 320.h,),
        Text(
          'Welcome back!',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 20.h,),
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
        SizedBox(height: 20.h,),
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
        SizedBox(height: 70.h,),
        GestureDetector(
          onTap: (){
            if(widget.viewModel.formKey.currentState!.validate()){
              widget.viewModel.login(widget.viewModel.emailController.text, widget.viewModel.passwordController.text);
            }
          },
          child: Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            color: Color(0xFF3597DA),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Log In',style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),),
                Icon(Icons.arrow_forward,color: Colors.white,)
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h,),
      ],
    );
  }
}
