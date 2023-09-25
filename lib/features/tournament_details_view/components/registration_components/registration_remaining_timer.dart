import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class RegistrationRemainingTimer extends StatelessWidget {
  const RegistrationRemainingTimer(
      {super.key,
      required this.height,
      required this.width,
      required this.days,
      required this.hours,
      required this.minuts,
      required this.seconds});

  final double height;
  final double width;
  final String days;
  final String hours;
  final String minuts;
  final String seconds;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.large, vertical: AppPadding.medium),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(
              0.5,
            ),
            blurRadius: 7,
            offset: const Offset(
              0,
              3,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Registration closes in",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12,
              fontFamily: "Lato",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$days \n Days',
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontFamily: "SFUIDisplay",
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                '$hours \n Hours',
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontFamily: "SFUIDisplay",
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                "$minuts \n Minutes",
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontFamily: "SFUIDisplay",
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Text(
                "$seconds \n Seconds",
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontFamily: "SFUIDisplay",
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
