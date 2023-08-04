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
        Text(
          "This code will expired in ",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          timerText.toString(),
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
