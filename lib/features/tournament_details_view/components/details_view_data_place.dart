import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/date_and_place_box.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class DetailsViewDateTime extends StatelessWidget {
  const DetailsViewDateTime(
      {super.key,
      required this.hight,
      required this.width,
      required this.dateIcon,
      required this.placeIcon,
      required this.date,
      required this.place});

  final double hight;
  final double width;
  final IconData dateIcon;
  final IconData placeIcon;
  final String date;
  final String place;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          DataandPlaceBox(
            hight: hight,
            width: width,
            icon: dateIcon,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              date,
              style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 12,
                color: AppColors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
          const SizedBox(
            width: AppMargin.large,
          ),
          DataandPlaceBox(
            hight: hight,
            width: width,
            icon: placeIcon,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              place,
              style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 12,
                color: AppColors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }
}
