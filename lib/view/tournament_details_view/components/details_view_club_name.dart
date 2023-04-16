import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/circle_images.dart';
import 'package:offpitch_app/res/constats.dart';

class DetailsViewClubName extends StatelessWidget {
  const DetailsViewClubName({super.key, required this.clubImage, required this.clubName});

  final String clubImage;
  final String clubName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.large,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleImages(
            image: clubImage,
            hight: 54,
            width: 54,
          ),
          const SizedBox(
            width: AppMargin.small,
          ),
          Text(
            clubName,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
