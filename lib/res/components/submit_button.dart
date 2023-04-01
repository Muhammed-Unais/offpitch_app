import 'package:flutter/material.dart';
import 'package:offpitch_app/res/colors.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {super.key,
      required this.buttonChildtext,
      required this.actionFunction,
      this.isLoading = false});

  final String buttonChildtext;
  final VoidCallback actionFunction;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: actionFunction,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.offpitchOrange,
        foregroundColor: AppColors.offpitchwhite,
        textStyle: TextStyle(
          color: AppColors.offpitchwhite,
        ),
      ),
      child: isLoading
          ? CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.offpitchwhite,
            )
          : Text(
              buttonChildtext,
            ),
    );
  }
}
