import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class EmptyComponts extends StatelessWidget {
  const EmptyComponts(
      {super.key,
      required this.image,
      required this.showMessage,
      required this.height,
      required this.width,
      required this.addText});

  final String image;
  final String showMessage;
  final double height;
  final double width;
  final String addText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.small),
          height: height,
          width: width,
          child: SvgPicture.asset(
            image,
          ),
        ),
        Text.rich(
          TextSpan(
            text: showMessage,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontFamily: "SFUIDisplay",
              fontWeight: FontWeight.bold,
            ),
            children: [
              const TextSpan(text: ' '),
              TextSpan(
                text: addText,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primary,
                  fontFamily: "SFUIDisplay",
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
