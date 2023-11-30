import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/user_profile_details/widgets/user_profile_settings_expansion.dart';
import 'package:readmore/readmore.dart';

class UserProfileAboutUsExpansion extends StatelessWidget {
  const UserProfileAboutUsExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      
      shape: const Border(
        bottom: BorderSide(color: AppColors.grey, width: 0.4),
      ),
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      expandedAlignment: Alignment.topCenter,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      tilePadding: EdgeInsets.all(0),
      childrenPadding: EdgeInsets.all(0),
      leading: Icon(Icons.info_rounded),
      title:const Text(
        "About us",
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      children:const  [
         Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 6),
              child: CirclePainterWidget(radius: 3.5, color: AppColors.primary),
            ),
            Text(
              "Why us",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppMargin.small,
        ),
        ReadMoreText(
          "We believe that organizing and participating in football tournaments should be an easy and enjoyable experience, which is why we've created a platform that is intuitive, easy-to-use, and packed with powerful features. From creating your own tournaments to registering your club for existing ones, we makes it simple to manage every aspect of the tournament organization process.",
          style: TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(
          height: AppMargin.small,
        ),
        Text(
          "offpitch© offpitch all rights reserved. 2023.",
          style: TextStyle(
            fontFamily: "SFUIDisplay",
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
