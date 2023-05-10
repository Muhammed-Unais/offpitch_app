import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/styles/constats.dart';

class TabbarViewOneEmailPhone extends StatelessWidget {
  const TabbarViewOneEmailPhone(
      {super.key, required this.email, required this.phone, required this.hight});

  final String email;
  final int phone;
  final double hight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: double.infinity,
      margin:const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: Column(
        children: [
          SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.email,
                      color: AppColors.black,
                      size: 22,
                    ),
                    const SizedBox(
                      width: AppMargin.small,
                    ),
                    Text(
                      email,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
                const SizedBox(
                  height: AppPadding.small,
                ),
                Row(
                  children: [
                    const Icon(
                      size: 22,
                      Icons.call,
                      color: AppColors.black,
                    ),
                    const SizedBox(
                      width: AppMargin.small,
                    ),
                    Text(
                      phone.toString(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
