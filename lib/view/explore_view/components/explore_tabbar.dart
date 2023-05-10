import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/styles/constats.dart';

class ExploreTabBar extends StatelessWidget {
  const ExploreTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: AppMargin.medium),
      color: Colors.grey.shade100,
      height: size.height * 0.05,
      width: double.infinity,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: AppPadding.large),
        // indicatorWeight: 5,
        indicatorColor: AppColors.primary,
        controller: tabController,
        onTap: (value) {
        },
        tabs: [
          Tab(
            child: Text(
              "Today Matches",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Tab(
            child: Text(
              "Tournaments",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
