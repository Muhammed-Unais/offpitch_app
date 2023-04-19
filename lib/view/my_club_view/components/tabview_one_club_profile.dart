import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/components/circle_images.dart';
import 'package:offpitch_app/res/constats.dart';

class TabViewOneClubProfile extends StatelessWidget {
  const TabViewOneClubProfile({super.key, required this.image, required this.clubName, required this.playerCount,});

  final String image;
  final String clubName;
  final int playerCount;
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      margin: const EdgeInsetsDirectional.symmetric(
        vertical: AppMargin.medium,
        horizontal: AppMargin.large,
      ),
      child: Row(
        children: [
          Flexible(
            flex: 5,
            child: CircleImages(
              hight: 80,
              width: 80,
              image: image,
              radius: AppRadius.borderRadiusXL,
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clubName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  "Players:$playerCount",
                  style: Theme.of(context).textTheme.titleMedium,
                )
              ],
            ),
          ),
          const Spacer(
            flex: 8,
          ),
          const Flexible(
            flex: 1,
            child: Icon(
              Icons.edit_square,
              color: AppColors.black,
            ),
          )
        ],
      ),
    );
  }
}
