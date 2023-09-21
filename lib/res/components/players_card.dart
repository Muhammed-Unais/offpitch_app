import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class PlayersCard extends StatelessWidget {
  const PlayersCard(
      {super.key,
      required this.image,
      required this.playerName,
      this.buttonAction,
      required this.dob});

  final String? image;
  final DateTime? dob;
  final String? playerName;
  final void Function()? buttonAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 7, bottom: 5),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppRadius.borderRadiusS),
        image: DecorationImage(
          colorFilter: const ColorFilter.mode(
            Colors.black38,
            BlendMode.darken,
          ),
          fit: BoxFit.cover,
          image: NetworkImage(
            image!,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    playerName!,
                    style: const TextStyle(
                      overflow: TextOverflow.clip,
                      fontFamily: "SFUIDisplay",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Age: ${dobToAge(dob)}',
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontFamily: "SFUIDisplay",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String dobToAge(DateTime? dobs) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    DateTime dob = DateTime(dobs!.year, dobs.month, dobs.day);
    Duration difference = date.difference(dob);
    int ageInDays = difference.inDays;
    int ageInYears = (ageInDays / 365).floor();
    return ageInYears.toString();
  }
}

class AddPlayerCard extends StatelessWidget {
  const AddPlayerCard({super.key, this.buttonAction});

  final void Function()? buttonAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 7, bottom: 5),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppRadius.borderRadiusS),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: buttonAction,
              child: const CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 26,
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 26,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Text(
              "Add Players",
              style: TextStyle(
                fontFamily: "SFUIDisplay",
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
