import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class CreateTournamentViewTabbar extends StatefulWidget {
  const CreateTournamentViewTabbar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<CreateTournamentViewTabbar> createState() =>
      _CreateTournamentViewTabbarState();
}

class _CreateTournamentViewTabbarState
    extends State<CreateTournamentViewTabbar> {
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
        top: AppMargin.medium,
      ),
      child: TabBar(
        onTap: (value) {
          widget.tabController.index = 0;
        },
        controller: widget.tabController,
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
            text: "1",
          ),
          Tab(
            text: "2",
          ),
          Tab(
            text: "3",
          )
        ],
      ),
    );
  }
}
