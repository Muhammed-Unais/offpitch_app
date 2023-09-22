import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class SmallOtpForm extends StatelessWidget {
  const SmallOtpForm(
      {super.key,
      required this.onChanged,
      this.focusNode,
      required this.validator,
      this.onTap});

  final void Function(String?) onChanged;
  final FocusNode? focusNode;
  final String? Function(String?) validator;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width / 8,
      child: TextFormField(
        onTap: onTap,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          LengthLimitingTextInputFormatter(1),
        ],
        validator: validator,
        keyboardType: TextInputType.number,
        autofocus: false,
        focusNode: focusNode,
        style: const TextStyle(
          fontFamily: "SFUIDisplay",
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              15,
            ),
            borderSide: const BorderSide(
              color: AppColors.primary,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
