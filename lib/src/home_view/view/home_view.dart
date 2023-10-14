import 'package:flutter/material.dart';
import 'package:offpitch_app/src/home_view/components/home_body.dart';
import 'package:offpitch_app/src/home_view/components/home_create_tournament_icon.dart';
import 'package:offpitch_app/src/home_view/components/home_titile_widget.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HomeTitleWidget(),
        actions: const [HomeCreateTournamentIcon()],
        centerTitle: false,
      ),
      backgroundColor: AppColors.white,
      body: const SafeArea(
        child: HomeBody(),
      ),
    );
  }
}
