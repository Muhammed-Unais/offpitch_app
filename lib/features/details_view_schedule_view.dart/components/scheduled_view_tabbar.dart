import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class ScheduledViewTabbar extends StatelessWidget {
  const ScheduledViewTabbar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.lightgrey,
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusS,
        ),
      ),
      child: TabBar(
        controller: tabController,
        labelStyle:const TextStyle(
          fontSize: 12,
          fontFamily: "Lato",
          fontWeight: FontWeight.bold,
          color: AppColors.black
        ),
        splashBorderRadius: BorderRadius.circular(AppRadius.borderRadiusS),
        labelColor: AppColors.white,
        indicatorPadding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.borderRadiusS),
          color: AppColors.primary,
        ),
        tabs: const [
          Tab(
            text: "Matches",
          ),
          Tab(
            text: "About",
          ),
        ],
      ),
    );
  }
}
