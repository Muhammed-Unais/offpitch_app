import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class ClubProfileNameWidget extends StatelessWidget {
  const ClubProfileNameWidget(
      {super.key, required this.clubName, required this.clubCover, required this.fontsize});

  final String clubName;
  final Widget clubCover;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          clubCover,
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              clubName,
              style:  TextStyle(
                fontSize: fontsize,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
