import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class ExploreTabBar extends StatelessWidget {
  const ExploreTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey.shade100,
      height: size.height * 0.05,
      width: double.infinity,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: AppPadding.large),
        // indicatorWeight: 5,
        indicatorColor: AppColors.primary,
        controller: tabController,
        tabs: [
          Tab(
            child: Text(
              "Today Matches",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Tab(
            child: Text(
              "Upcoming",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
