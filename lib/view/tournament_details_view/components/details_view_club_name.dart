import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/circle_images.dart';
import 'package:offpitch_app/res/constats.dart';

class DetailsViewClubName extends StatelessWidget {
  const DetailsViewClubName({super.key, required this.clubImage, required this.clubName});

  final String clubImage;
  final String clubName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleImages(
            radius: AppRadius.borderRadiusL,
            image: clubImage,
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
