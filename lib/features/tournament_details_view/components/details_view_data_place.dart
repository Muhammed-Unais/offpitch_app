import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/date_and_place_box.dart';
import 'package:offpitch_app/res/constats.dart';

class DetailsViewDateTime extends StatelessWidget {
  const DetailsViewDateTime(
      {super.key,
      required this.hight,
      required this.width,
      required this.dateIcon,
      required this.placeIcon, required this.date,required this.place});

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
            width: AppMargin.extraSmall,
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(
            width: AppMargin.large,
          ),
          DataandPlaceBox(
            hight: hight,
            width: width,
            icon: placeIcon,
          ),
          const SizedBox(
            width: AppMargin.extraSmall,
          ),
          Text(
            place,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
