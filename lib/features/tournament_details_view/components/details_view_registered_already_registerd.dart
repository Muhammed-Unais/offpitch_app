import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class DeilsViewRegisterdAlreadyRegisterd extends StatelessWidget {
  const DeilsViewRegisterdAlreadyRegisterd({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppMargin.large),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/images/registered.svg",
            height: 120,
            width: 120,
          ),
          const SizedBox(
            height: AppMargin.extraSmall,
          ),
          const Text(
            textAlign: TextAlign.center,
            "Already Registered",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "SFUIDisplay",
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
