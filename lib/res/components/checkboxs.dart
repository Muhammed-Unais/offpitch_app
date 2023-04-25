import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';

class CheckBoxs extends StatelessWidget {
  const CheckBoxs({super.key, required this.isCheck, required this.function});
  final bool? isCheck;
  final void Function(bool?) function;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: AppColors.primary,
      checkColor: AppColors.white,
      value: isCheck,
      onChanged: function,
    );
  }
}
