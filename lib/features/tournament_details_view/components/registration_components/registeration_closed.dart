import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class RegistrationClosed extends StatelessWidget {
  const RegistrationClosed({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          SvgPicture.asset(
            theme: const SvgTheme(currentColor: Colors.grey),
            "assets/images/access-denied.svg",
            height: 120,
            width: 120,
          ),
          const SizedBox(
            height: AppMargin.small,
          ),
          const Text(
            textAlign: TextAlign.center,
            "Registration Closed",
            style: TextStyle(
              fontFamily: "SFUIDisplay",
              fontSize: 12,
              color: AppColors.grey,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
