import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.small),
          height: 160,
          width: 160,
          child: SvgPicture.asset(
            "assets/images/no-data.svg",
          ),
        ),
        Text(
          errorMessage,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class EmptyComponentPng extends StatelessWidget {
  const EmptyComponentPng(
      {super.key, required this.errorMessage, required this.imagePath, required this.hight, required this.width});

  final String errorMessage;
  final String imagePath;
  final double hight;
  final double width;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: AppMargin.small),
          height: hight,
          width: width,
          child: Image.asset(
            imagePath,
          ),
        ),
        Text(
          errorMessage,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
