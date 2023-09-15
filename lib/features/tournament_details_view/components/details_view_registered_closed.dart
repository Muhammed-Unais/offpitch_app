import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class DetailsViewRegistedClosed extends StatelessWidget {
  const DetailsViewRegistedClosed({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.large),
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
              fontSize: 18,
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
