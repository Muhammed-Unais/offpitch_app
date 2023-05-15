import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/players_card.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class DetailsViewRegisteredTeams extends StatelessWidget {
  const DetailsViewRegisteredTeams({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height / 1.6,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // main bg================
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              height: size.height / 2.1,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.borderRadiusXL),
                  topRight: Radius.circular(AppRadius.borderRadiusXL),
                ),
              ),
            ),
          ),
          // CircleAvatar================
          const Positioned(
            top: 24,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.white,
              radius: 55,
              child: CircleAvatar(
                radius: 54,
                backgroundColor: AppColors.black,
                backgroundImage: AssetImage(
                    "assets/images/pexels-dmitry-demidov-6764885.jpg"),
              ),
            ),
          ),
          Positioned(
            top: 155,
            child: Text(
              "Club Calicut",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Positioned(
            left: AppMargin.large + AppMargin.extraSmall,
            top: 200,
            child: Text(
              "Players",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Positioned(
            left: AppMargin.large + AppMargin.extraSmall,
            right: AppMargin.large + AppMargin.extraSmall,
            top: 250,
            child: SizedBox(
              height: 200,
              width: size.width,
              child: ListView.builder(
                itemCount: 30,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return PlayersCard(
                    image: AppProfilesCover.clubCover,
                    playerName: "Unais",
                    dob: DateTime(2001, 03, 12),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
