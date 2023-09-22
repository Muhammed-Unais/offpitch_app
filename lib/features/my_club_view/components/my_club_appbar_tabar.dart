import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class MyclubAppbarTabbar extends StatelessWidget {
  const MyclubAppbarTabbar({
    super.key,
  });

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      shape: const Border(
        bottom: BorderSide(color: Colors.black, width: 0.5),
      ),
      backgroundColor: AppColors.white,
      shadowColor: AppColors.white,
      centerTitle: false,
      title: const Text(
        "CLUB DETAILS",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      bottom: TabBar(
        onTap: (value) {},
        padding: const EdgeInsets.only(left: 20, right: 20),
        labelStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        splashBorderRadius: BorderRadius.circular(AppRadius.borderRadiusS),
        labelColor: AppColors.black,
        indicatorColor: AppColors.black,
        indicatorPadding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: AppColors.grey,
        tabs: const [
          Tab(
            text: "Overview",
          ),
          Tab(
            text: "Hosted",
          ),
          Tab(
            text: "Registered",
          )
        ],
      ),
    );
  }
}
