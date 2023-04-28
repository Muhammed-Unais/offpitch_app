import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';

class ClubCreationAppBar extends StatelessWidget {
  const ClubCreationAppBar({super.key, this.appBarText = "Create New Club"});

  final String appBarText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Divider(
          thickness: 0.5,
          color: AppColors.grey,
        ),
      ),
      shadowColor: AppColors.white,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: Text(appBarText),
    );
  }
}
