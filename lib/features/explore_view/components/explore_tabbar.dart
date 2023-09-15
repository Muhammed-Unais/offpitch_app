import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class ExploreTabBar extends StatelessWidget {
  const ExploreTabBar(
      {super.key,
      required this.tabController,
      required this.firstTab,
      required this.secondTab});

  final TabController tabController;
  final String firstTab;
  final String secondTab;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(
            color: AppColors.grey,
          ),
        ),
        color: Colors.grey.shade100,
      ),
      margin: const EdgeInsetsDirectional.only(bottom: AppMargin.medium),
      height: size.height * 0.05,
      width: double.infinity,
      child: TabBar(
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
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Tab(
            child: Text(
              secondTab,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }
}
