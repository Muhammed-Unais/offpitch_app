import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class MyclubAppbarTabbar extends StatelessWidget {
  const MyclubAppbarTabbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const Border(
        bottom: BorderSide(color: Colors.grey, width: 0.5),
      ),
      backgroundColor: AppColors.white,
      shadowColor: AppColors.white,
      title: const Text(
        "Club Details",
      ),
      bottom: TabBar(
        onTap: (value) {},
        labelStyle: Theme.of(context).textTheme.titleMedium,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.primary,
        indicatorColor: AppColors.primary,
        tabs: const <Widget>[
          Tab(
            text: "Overview",
          ),
          Tab(
            text: "Tournament",
          ),
          Tab(
            text: "Registered",
          )
        ],
      ),
    );
  }
}
