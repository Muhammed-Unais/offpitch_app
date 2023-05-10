import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/view/home_view/components/home_body.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) =>  HomeAndExpViewModel(),
      child: const Scaffold(
        backgroundColor: AppColors.primary,
        body:HomeBody()
      ),
    );
  }
}
