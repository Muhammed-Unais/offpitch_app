import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent(
      {super.key,
      required this.errorMessage,
      required this.hight,
      required this.width});

  final String errorMessage;
  final double hight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: hight,
            width: width,
            margin: const EdgeInsets.only(bottom: AppMargin.small),
            child: Image.asset(
              "assets/images/Computer troubleshooting-rafiki.png",
            ),
          ),
          Text(
            errorMessage,
            style: const TextStyle(
              fontFamily: "SFUIDisplay",
              color: AppColors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyComponentPng extends StatelessWidget {
  const EmptyComponentPng(
      {super.key,
      required this.errorMessage,
      required this.imagePath,
      required this.hight,
      required this.width});

  final String errorMessage;
  final String imagePath;
  final double hight;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: hight,
          width: width,
          child: Image.asset(
            imagePath,
          ),
        ),
        Text(
          errorMessage,
          style: const TextStyle(
            fontFamily: "SFUIDisplay",
            color: AppColors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
