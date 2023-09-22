import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/components/circle_images.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/features/club_creation_view/view_model/create_new_club_view_model.dart';
import 'package:provider/provider.dart';

class TabViewOneClubProfile extends StatelessWidget {
  const TabViewOneClubProfile({
    super.key,
    required this.image,
    required this.clubName,
    required this.playerCount,
  });

  final String image;
  final String clubName;
  final int playerCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: CircleImages(
              image: image,
              radius: 42,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clubName,
                  style: const TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Players: $playerCount",
                  style: const TextStyle(
                    fontFamily: "SFUIDisplay",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                context.read<CreateNewClubViewModel>().setOptions(false);
                context
                    .read<CreateNewClubViewModel>()
                    .editValueAssaignFunc(context);
                Navigator.pushNamed(context, RoutesName.clubCreation);
              },
              child: const Icon(
                Icons.edit_square,
                color: AppColors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
