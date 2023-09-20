import 'package:flutter/material.dart';
import 'package:offpitch_app/features/home_view/components/home_frosted_glass_widget.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

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
