import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class HomeCreateTournamentIcon extends StatelessWidget {
  const HomeCreateTournamentIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(right: 20,top: 10),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 40,
      width: 40,
      child: IconButton(
        onPressed: () {
          Navigator.pushNamed(context, "host_tournament");
        },
        icon: const Icon(
          Icons.add,
          color: AppColors.white,
        ),
      ),
    );
  }
}