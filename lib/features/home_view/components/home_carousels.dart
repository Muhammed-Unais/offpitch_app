import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/features/bottom_bar_view/view_model/bottom_bar_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeCarousels extends StatelessWidget {
  const HomeCarousels({
    super.key,
    required this.image,
    required this.tournamentName,
    required this.dateAndTime,
    required this.location,
  });

  final String image;
  final String tournamentName;
  final String dateAndTime;
  final String location;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(10),
      width: size.width - 80,
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(
          AppRadius.borderRadiusS,
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
      ),
      child: FrostedGlassBox(
        stackLastWidget: FrostedGlassChildWidget(
          hight: size.height * 0.1,
          width: size.width,
          startinDate: dateAndTime,
          tournamentName: tournamentName,
        ),
        location: location,
        hight: size.height * 0.1,
        width: size.width,
      ),
    );
  }
}

class HomeTournametnCard extends StatelessWidget {
  const HomeTournametnCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 80,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primary,
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
                context.read<BottomBarViewModel>().onTap(3, context);
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

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox(
      {super.key,
      required this.hight,
      required this.width,
      required this.location,
      required this.stackLastWidget});

  final double hight;
  final double width;

  final String location;
  final Widget stackLastWidget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: hight,
        width: width,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.5)
                  ],
                ),
              ),
            ),
            stackLastWidget,
            Positioned(
              right: 10,
              bottom: 8,
              child: Row(
                children: [
                  const Icon(
                    size: 16,
                    Icons.location_on_rounded,
                    color: AppColors.primary,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FrostedGlassChildWidget extends StatelessWidget {
  const FrostedGlassChildWidget({
    super.key,
    required this.hight,
    required this.width,
    required this.startinDate,
    required this.tournamentName,
  });

  final double hight;
  final double width;
  final String startinDate;
  final String tournamentName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            startinDate,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            tournamentName,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}


