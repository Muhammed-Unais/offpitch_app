import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class OtpTimer extends StatelessWidget {
  const OtpTimer({super.key, required this.timerText});

  final String timerText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "This code will expired in ",
          style: TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
        Text(
          timerText.toString(),
          style: const TextStyle(
            fontFamily: "SFUIDisplay",
            color: AppColors.primary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
