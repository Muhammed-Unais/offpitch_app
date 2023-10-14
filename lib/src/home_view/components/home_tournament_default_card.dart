import 'package:flutter/material.dart';
import 'package:offpitch_app/src/bottom_bar_view/view_model/bottom_bar_viewmodel.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:provider/provider.dart';

class HomeTournametnCard extends StatelessWidget {
  const HomeTournametnCard({
    super.key, this.reduceWidth =80,
  });

  final double reduceWidth;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width - reduceWidth,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: AppColors.black,
        ),
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusS,
        ),
        image: const DecorationImage(
          image: AssetImage("assets/images/hero-img.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 20,
            bottom: 55,
            child: Text(
              "Elevate Your\nFootball Experience",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                context.read<BottomBarViewModel>().onTap(2, context);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.large),
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    fontFamily: "SFUIDisplay",
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
