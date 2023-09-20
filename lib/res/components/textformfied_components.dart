import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/utils.dart';

class TextFormFieldsComponent extends StatelessWidget {
  const TextFormFieldsComponent(
      {super.key,
      required this.hintText,
      required this.maxLines,
      required this.controller,
      this.type,
      this.validator,
      this.isOutfoucsNode = false,
      required this.currentFocusNode,
      required this.nextFocusNode,
      this.onTap,
      this.enabled,
      this.maxlength});

  final String hintText;
  final Function()? onTap;
  final int? maxLines;
  final TextEditingController controller;
  final TextInputType? type;
  final String? Function(String?)? validator;
  final bool isOutfoucsNode;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final bool? enabled;
  final int? maxlength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 12,
        fontFamily: "SFUIDisplay",
        fontWeight: FontWeight.bold,
      ),
      scrollPadding: const EdgeInsets.all(0),
      enabled: enabled,
      onTap: onTap,
      onFieldSubmitted: (value) => Utils.fieldFocusChange(
        context: context,
        isOutfocusNode: isOutfoucsNode,
        current: currentFocusNode,
        nextFocus: nextFocusNode,
      ),
      validator: validator,
      keyboardType: type,
      focusNode: currentFocusNode,
      controller: controller,
      maxLines: maxLines,
      enableSuggestions: true,
      maxLength: maxlength,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 12, fontFamily: "SFUIDisplay"),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
