import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

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
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Expanded(
            child: ClipOval(
              child: 
              FadeInImage(
                height: 70,
                width: 70,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.cover,
                placeholder: const AssetImage(
                  AppProfilesCover.playerCover,
                ),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(

                    AppProfilesCover.playerCover,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  );
                },
                placeholderErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppProfilesCover.playerCover,
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  );
                },
                image: NetworkImage(
                  image!,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            playerName!,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: "Lato",
              fontSize: 12,
              color: AppColors.black,
            ),
            textAlign: TextAlign.center,
          ),
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
    return GestureDetector(
      onTap: buttonAction,
      child: const SizedBox(
        width: 80,
        child: Column(
          children: [
            Expanded(
              child: CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 42,
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Add player",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Lato",
                fontSize: 12,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
