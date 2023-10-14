import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';

class TournamentProfile extends StatelessWidget {
  const TournamentProfile(
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
