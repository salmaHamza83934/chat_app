import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  String label;
  TextInputType keyboardType;
  bool obscuretxt;
  IconData? suffix;
  Function()? pressed;

      TextEditingController controller;
  String? Function(String?)? validator;
  CustomTextFormField(
      {super.key,
        required this.label,
        this.keyboardType = TextInputType.text,
        this.obscuretxt = false,
        required this.controller,
        this.suffix,
        this.pressed,
        required this.validator,
      });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      decoration: InputDecoration(
          suffixIcon: suffix != null
              ? IconButton(
            onPressed: pressed,
            icon: Icon(
              suffix,
              color: theme.primaryColor,
            ),
          )
              : null,
          label: Text(
            label,
            style: theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theme.primaryColor, width: 3)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theme.primaryColor, width: 2))),
      keyboardType: keyboardType,
      obscureText: obscuretxt,
      controller: controller,
      validator: validator,
    );
  }
}
