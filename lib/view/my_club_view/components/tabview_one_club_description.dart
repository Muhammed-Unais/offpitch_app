import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:readmore/readmore.dart';

class TabViewOneClubDescription extends StatelessWidget {
  const TabViewOneClubDescription(
      {super.key,
      required this.description, required this.hight,
     });

  final double hight;
  // final double width;
  final String description;
 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReadMoreText(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.start,
              trimMode: TrimMode.Line,
              trimLines: 8,
            ),
          ],
        ),
      ),
    );
  }
}
