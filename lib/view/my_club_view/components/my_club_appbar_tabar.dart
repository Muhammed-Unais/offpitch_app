import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';

class MyclubAppbarTabbar extends StatelessWidget {
  const MyclubAppbarTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      shadowColor: AppColors.white,
      elevation: 5,
      title: const Text(
        "Club Details",
      ),
      bottom: TabBar(
        labelStyle:Theme.of(context).textTheme.titleMedium,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.primary,
        indicatorColor: AppColors.primary,
        tabs: const <Widget>[
          Tab(text: "Overview",),
          Tab(text: "Tournament",),
          Tab(text: "Registered",)
        ],
      ),
    );
  }
}
