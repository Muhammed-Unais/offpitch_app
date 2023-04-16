import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';

class DataandPlaceBox extends StatelessWidget {
  const DataandPlaceBox({super.key, required this.hight, required this.width, required this.icon});

  final double hight;
  final double width;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(AppRadius.borderRadiusS)),
      height: hight,
      width: width,
      child: Icon(icon),
    );
  }
}
