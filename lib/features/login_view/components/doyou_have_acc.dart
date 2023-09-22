import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';

class DoyouhaveAcc extends StatelessWidget {
  const DoyouhaveAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.signup);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Dont have an account? ",
            style: TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          ),
          Text(
            "Sign up",
            style:TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
          ),
        ],
      ),
    );
  }
}
