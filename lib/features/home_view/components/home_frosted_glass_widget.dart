import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

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