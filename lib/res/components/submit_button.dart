import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {super.key,
      required this.buttonChildtext,
      required this.actionFunction,
      this.isLoading = false});

  final String buttonChildtext;
  final VoidCallback? actionFunction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: actionFunction,
        style: ElevatedButton.styleFrom(),
        child: isLoading
            ? const CircularProgressIndicator(
                strokeWidth: 4,
                color: AppColors.white,
              )
            : Text(
                buttonChildtext,
                style: const TextStyle(
                  fontFamily: "SFUIDisplay",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
      ),
    );
  }
}
