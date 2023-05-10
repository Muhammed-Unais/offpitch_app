import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view/user_profile_view/widgets/user_profile_logout_alert_dia.dart';

class UserProfileSettingsExpansion extends StatelessWidget {
  const UserProfileSettingsExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      title: Text("Settings", style: Theme.of(context).textTheme.labelLarge),
      children: [
        const Divider(
          color: AppColors.black,
          thickness: 0.5,
        ),
        InkWell(
            onTap: () {
             
            },
            child: Text(
              "ShareApp",
              style: Theme.of(context).textTheme.labelLarge,
            )),
        const Divider(
          color: AppColors.black,
          thickness: 0.5,
        ),
        Text(
          "Notification",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const Divider(
          color: AppColors.black,
          thickness: 0.5,
        ),
        InkWell(
          onTap: () {
             Utils.showDialogue(context, child: const LogoutAlertDialog());
          },
          child: Text(
            "Logout",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        const Divider(
          color: AppColors.black,
          thickness: 0.5,
        ),
      ],
    );
  }
}
