import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class TabbarWidget extends StatefulWidget {
  const TabbarWidget({
    super.key,
    required this.tabController,
    required this.selectedTabColor,
    required this.tabOne,
    required this.tabTwo,
    required this.tabThree,
    this.margin,
    required this.hight, this.onTap,
  });

  final TabController tabController;
  final Color selectedTabColor;
  final String tabOne;
  final String tabTwo;
  final String tabThree;
  final EdgeInsetsGeometry? margin;
  final double hight;
  final void Function(int)? onTap;

  @override
  State<TabbarWidget> createState() => TabbarWidgetState();
}

class TabbarWidgetState extends State<TabbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.hight,
      decoration: BoxDecoration(
        color: AppColors.lightgrey,
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusS,
        ),
      ),
      margin: widget.margin,
      child: TabBar(
        onTap: widget.onTap,
        controller: widget.tabController,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: "Pilat",
        ),
        splashBorderRadius: BorderRadius.circular(AppRadius.borderRadiusS),
        labelColor: AppColors.white,
        indicatorPadding:
            const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.borderRadiusS),
          color: widget.selectedTabColor,
        ),
        tabs: [
          Tab(
            text: widget.tabOne,
          ),
          Tab(
            text: widget.tabTwo,
          ),
          Tab(
            text: widget.tabThree,
          )
        ],
      ),
    );
  }
}
