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
        shape: const Border(
          bottom: BorderSide(
            width: 0.4,
            color: AppColors.grey,
          ),
        ),
        elevation: 2,
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.white,
        ),
        centerTitle: false,
        backgroundColor: AppColors.white,
        title: const Text(
          "Home",
          style: TextStyle(
            color: AppColors.black,
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
