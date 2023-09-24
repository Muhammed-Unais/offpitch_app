import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/circle_images.dart';

import 'package:offpitch_app/res/styles/app_theme.dart';

class DetailsViewClubName extends StatelessWidget {
  const DetailsViewClubName(
      {super.key, required this.clubImage, required this.clubName});

  final String clubImage;
  final String clubName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleImages(
            radius: 36,
            image: clubImage,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              clubName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
