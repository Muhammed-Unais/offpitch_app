import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/splash_screen/view_model/user_view_model.dart';
import 'package:offpitch_app/src/bottom_bar_view/view_model/bottom_bar_viewmodel.dart';
import 'package:provider/provider.dart';

class UserProfileClubCard extends StatelessWidget {
  const UserProfileClubCard({
    super.key,
    this.clubCover,
    this.clubName,
    this.playersCount,
    this.clubStatus,
  });

  final String? clubCover;
  final String? clubName;
  final int? playersCount;
  final String? clubStatus;

  @override
  Widget build(BuildContext context) {
    final String? userClubId = context.watch<UserViewModel>().userClubId;

    return Card(
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(width: 0.2, color: AppColors.black),
      ),
      surfaceTintColor: AppColors.white,
      color: Theme.of(context).cardColor,
      elevation: 4,
      child: userClubId != null && userClubId.isNotEmpty
          ? ListTile(
              leading: ClipOval(
                child: FadeInImage(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage(
                    AppProfilesCover.clubCover,
                  ),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppProfilesCover.clubCover,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    );
                  },
                  placeholderErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppProfilesCover.clubCover,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    );
                  },
                  image: NetworkImage(
                    clubCover!,
                  ),
                ),
              ),
              title: Text(
                clubName?.toUpperCase() ?? "",
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "${playersCount ?? 0} PLAYERS",
                    style: const TextStyle(
                      fontFamily: "Lato",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: AppMargin.small,
                  ),
                  Text(
                    clubStatus?.toUpperCase() ?? "",
                    style: const TextStyle(
                      fontFamily: "Lato",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              trailing: InkWell(
                onTap: () {
                  context.read<BottomBarViewModel>().onTap(2, context);
                },
                child: const Text(
                  "View",
                  style: TextStyle(
                    fontFamily: "SFUIDisplay",
                    fontSize: 12,
                    color: AppColors.black,
                  ),
                ),
              ),
            )
          : ListTile(
              onTap: () {
                context.read<BottomBarViewModel>().onTap(2, context);
              },
              title: const Text(
                "You didn't create a club,Create Now",
                style: TextStyle(
                  fontFamily: "SFUIDisplay",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_right_alt,
                color: AppColors.primary,
                size: 20,
              ),
            ),
    );
  }
}
