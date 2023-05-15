import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/create_tournament_view_model/create_tournament_view_model.dart';

class CreateTournamentViewTabbar extends StatefulWidget {
  const CreateTournamentViewTabbar(
      {super.key, required this.tabController, required this.value});

  final TabController tabController;
  final CreateTournamentViewModel value;

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
      margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: TabBar(
        onTap: (value) {
          widget.tabController.index = 0;
          if (value == 2) {
            widget.tabController.index = 0; 
          }
          log("tab${widget.tabController.index.toString()}");
          log(value.toString());
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
            color: AppColors.primary),
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
