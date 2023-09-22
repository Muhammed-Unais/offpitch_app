import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class TabbarViewOneEmailPhone extends StatelessWidget {
  const TabbarViewOneEmailPhone(
      {super.key,
      required this.email,
      required this.phone,
      required this.hight});

  final String email;
  final int phone;
  final double hight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hight,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.email,
                color: AppColors.black,
                size: 16,
              ),
              const SizedBox(
                width: AppMargin.small,
              ),
              Text(
                email,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: "SFUIDisplay",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Icon(
                size: 16,
                Icons.call,
                color: AppColors.black,
              ),
              const SizedBox(
                width: AppMargin.small,
              ),
              Text(
                phone.toString(),
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontFamily: "SFUIDisplay",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
