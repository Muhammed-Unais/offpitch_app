import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/utils.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    super.key,
    required this.currentFocusNode,
    required this.controller,
    required this.nextFocusNode,
    required this.hintText,
    required this.labalText,
    this.formkey,
    required this.validator,
    this.obsecureText = false,
    required this.textInputType,
    this.obsecureValue = "",
    this.suffix,
    this.prefix,
    this.isoutFocusnode = false,
  });

  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final TextEditingController controller;
  final String hintText;
  final String labalText;
  final GlobalKey<FormFieldState>? formkey;
  final String? Function(String?) validator;
  final bool obsecureText;
  final TextInputType textInputType;
  final String obsecureValue;
  final Widget? suffix;
  final Widget? prefix;
  final bool isoutFocusnode;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.lightgrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: const TextStyle(
          fontFamily: "SFUIDisplay",
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        onChanged: (value) {},
        obscureText: obsecureText,
        focusNode: currentFocusNode,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          helperStyle: const TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          labelStyle: const TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          border: InputBorder.none,
          hintText: hintText,
          labelText: labalText,
          suffixIcon: suffix,
        ),
        onFieldSubmitted: (value) => Utils.fieldFocusChange(
          isOutfocusNode: isoutFocusnode,
          context: context,
          current: currentFocusNode,
          nextFocus: nextFocusNode,
        ),
        validator: validator,
        key: formkey,
      ),
    );
  }
}
