import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/constats.dart';

class DetailsViewTournamentImage extends StatelessWidget {
  const DetailsViewTournamentImage(
      {super.key,
      required this.hight,
      required this.width,
      required this.image});

  final double hight;
  final double width;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      margin: const EdgeInsets.symmetric(
        horizontal: AppMargin.large,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppRadius.borderRadiusS,
          ),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
      ),
    );
  }
}
