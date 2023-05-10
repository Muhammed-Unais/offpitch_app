import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/styles/constats.dart';

class TabbarMyClubView extends StatelessWidget {
  const TabbarMyClubView(
      {super.key,
      required this.tabController,
      required this.tabbar1,
      required this.tabbar2,
      required this.tabbar3});

  final TabController tabController;
  final String tabbar1;
  final String tabbar2;
  final String tabbar3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusL,
        ),
      ),
      margin: const EdgeInsets.only(
        left: AppMargin.large,
        right: AppMargin.large,
        top: AppMargin.large,
        bottom: AppPadding.extraSmall
      ),
      child: TabBar(
        onTap: (value) {},
        controller: tabController,
        labelStyle: Theme.of(context).textTheme.titleMedium,
        splashBorderRadius: BorderRadius.circular(AppRadius.borderRadiusL),
        labelColor: AppColors.white,
        indicatorPadding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.borderRadiusL),
            color: AppColors.primary),
        tabs: [
          Tab(
            text: tabbar1,
          ),
          Tab(
            text: tabbar2,
          ),
          Tab(
            text: tabbar3,
          )
        ],
      ),
    );
  }
}
