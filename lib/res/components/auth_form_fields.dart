import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/utils.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField(
      {super.key,
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
      decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.small, horizontal: AppPadding.medium),
        child: TextFormField(
          onChanged: (value) {},
          obscureText: obsecureText,
          focusNode: currentFocusNode,
          keyboardType: textInputType,
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            // prefixIcon: prefix,
            labelText: labalText,
            suffixIcon: suffix,
          ),
          onFieldSubmitted: (value) => Utils.fieldFocusChange(
            isOutfocusNode: isoutFocusnode,
            context: context,
            current: currentFocusNode,
            nextFocus: nextFocusNode,
          ),
          // validation
          validator: validator,
          key: formkey,
        ),
      ),
    );
  }
}
