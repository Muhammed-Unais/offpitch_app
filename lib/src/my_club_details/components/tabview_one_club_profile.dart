import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/src/club_creation/view_model/create_new_club_view_model.dart';
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
          ClipOval(
            child: FadeInImage(
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              placeholderFit: BoxFit.cover,
              placeholder: const AssetImage(
                AppProfilesCover.clubCover,
              ),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppProfilesCover.clubCover,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                );
              },
              placeholderErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppProfilesCover.clubCover,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                );
              },
              image: NetworkImage(image),
            ),
          ),
          const SizedBox(
            width: 20,
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Players: $playerCount",
                  style: const TextStyle(
                    fontFamily: "Lato",
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
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
