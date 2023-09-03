import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/view/home_view/components/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.white,
        ),
        centerTitle: false,
        backgroundColor: AppColors.primary,
        title: const Text(
          "Home",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: AppColors.white,
      body: const HomeBody(),
    );
  }
}
