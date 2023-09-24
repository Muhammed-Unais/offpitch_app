import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class DataandPlaceBox extends StatelessWidget {
  const DataandPlaceBox({super.key, required this.hight, required this.width, required this.icon});

  final double hight;
  final double width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightgrey,
          borderRadius: BorderRadius.circular(AppRadius.borderRadiusS)),
      height: hight,
      width: width,
      child: Icon(icon),
    );
  }
}
