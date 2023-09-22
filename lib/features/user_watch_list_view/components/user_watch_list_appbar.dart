import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class UserWatchlistAppbar extends StatelessWidget {
  const UserWatchlistAppbar({
    super.key,
  });

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
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back,
        ),
      ),
      title: const Text(
        "Watchlist",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }
}
