import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class PlayersCard extends StatelessWidget {
  const PlayersCard(
      {super.key,
      required this.image,
      this.isAddplayer = false,
      required this.playerName,
      this.buttonAction,
      required this.dob});

  final String? image;
  final DateTime? dob;
  final bool isAddplayer;
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
        image: isAddplayer
            ? null
            : DecorationImage(
                colorFilter: const ColorFilter.mode(
                  Colors.black54,
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
          isAddplayer
              ? Align(
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
                )
              : const SizedBox(),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: isAddplayer
                ? Text(
                    "Add Players",
                    style: Theme.of(context).textTheme.labelLarge,
                    textAlign: TextAlign.center,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          playerName!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Age: ${dobToAge(dob)}',
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
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
