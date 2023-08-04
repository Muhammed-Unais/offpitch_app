import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:readmore/readmore.dart';

class UserProfileAboutUsExpansion extends StatelessWidget {
  const UserProfileAboutUsExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      expandedAlignment: Alignment.topCenter,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      title: Text("About Us", style: Theme.of(context).textTheme.labelLarge),
      children: [
        const Text(
          "Why us",
          style: TextStyle(
              color: AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: AppMargin.small,
        ),
        ReadMoreText(
          "We believe that organizing and participating in football tournaments should be an easy and enjoyable experience, which is why we've created a platform that is intuitive, easy-to-use, and packed with powerful features. From creating your own tournaments to registering your club for existing ones, we makes it simple to manage every aspect of the tournament organization process.",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: AppMargin.small,
        ),
        Text(
          "offpitch© offpitch all rights reserved. 2023.",
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
