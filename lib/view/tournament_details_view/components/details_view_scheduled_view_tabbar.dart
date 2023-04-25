import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class DetailsTournamentScheduledViewTabbar extends StatelessWidget {
  const DetailsTournamentScheduledViewTabbar({
    super.key,
  });

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
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: TabBar(
        labelStyle: Theme.of(context).textTheme.titleMedium,
        splashBorderRadius: BorderRadius.circular(AppRadius.borderRadiusL),
        labelColor: AppColors.white,
        indicatorPadding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.borderRadiusL),
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
