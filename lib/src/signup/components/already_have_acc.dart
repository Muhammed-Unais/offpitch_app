import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class AlreadyHaveAcc extends StatelessWidget {
  const AlreadyHaveAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          ),
          Text(
            "Login",
            style: TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          ),
        ],
      ),
    );
  }
}
