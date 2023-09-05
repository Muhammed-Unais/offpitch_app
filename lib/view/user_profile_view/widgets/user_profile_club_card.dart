import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:offpitch_app/view_model/bottom_bar_viewmodel.dart';
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
    final userClubId =
        Provider.of<UserViewModel>(context, listen: false).userClubId;
    return Card(
      margin: const EdgeInsets.only(
          bottom: AppMargin.medium, top: AppPadding.small),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(width: 0.2, color: AppColors.black),
      ),
      surfaceTintColor: AppColors.white,
      color: Theme.of(context).cardColor,
      elevation: 4,
      child: userClubId != null && userClubId.isNotEmpty
          ? ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 24,
                backgroundImage: NetworkImage(
                  clubCover ?? AppProfilesCover.clubCover,
                ),
              ),
              title: Text(
                clubName ?? "",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              subtitle: Row(
                children: [
                  Text(
                    "${playersCount ?? 0} Players",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: AppMargin.small,
                  ),
                  Text(
                    clubStatus ?? "",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              trailing: InkWell(
                onTap: () {
                  Provider.of<BottomBarViewModel>(context, listen: false).onTap(
                    3,
                    context,
                  );
                },
                child: Text(
                  "View",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            )
          : ListTile(
              onTap: () {
                Provider.of<BottomBarViewModel>(context, listen: false).onTap(
                  3,
                  context,
                );
              },
              title: Text(
                "You didn't create a club,Create Now",
                style: Theme.of(context).textTheme.labelLarge,
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
