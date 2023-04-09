import 'package:flutter/material.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/view/home_view/components/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body:HomeBody()
    );
  }
}
