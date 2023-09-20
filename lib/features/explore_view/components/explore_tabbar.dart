import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class ExploreTabBar extends StatelessWidget {
  const ExploreTabBar(
      {super.key,
      required this.tabController,
      required this.firstTab,
      required this.secondTab,
      required this.thirdTab});

  final TabController tabController;
  final String firstTab;
  final String secondTab;
  final String thirdTab;

  @override
  Widget build(BuildContext context) {
    return 
     TabBar(
      indicator: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusS,
        ),
      ),
      labelColor: AppColors.white,
      unselectedLabelColor: AppColors.grey,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding:
          const EdgeInsets.symmetric(horizontal: AppPadding.large),
      indicatorColor: AppColors.primary,
      controller: tabController,
      onTap: (value) {},
      tabs: [
        Tab(
          child: Text(
            firstTab,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Tab(
          child: Text(
            secondTab,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Tab(
          child: Text(
            thirdTab,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
