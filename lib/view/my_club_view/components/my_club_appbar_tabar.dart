import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_user_hostreg_tournament_view_model.dart';
import 'package:provider/provider.dart';

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
        onTap: (value) {
        },
        labelStyle: Theme.of(context).textTheme.titleMedium,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColors.primary,
        indicatorColor: AppColors.primary,
        tabs: const <Widget>[
          Tab(
            text: "Overview",
          ),
          Tab(
            text: "Tournament",
          ),
          Tab(
            text: "Registered",
          )
        ],
      ),
    );
  }
}
