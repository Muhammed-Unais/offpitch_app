import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class MatchesResultCards extends StatelessWidget {
  const MatchesResultCards(
      {super.key,
      this.matchNo,
      this.team1Cover,
      this.team2Cover,
      this.team1Name,
      this.team2Name,
      this.team1Goal,
      this.team2Goal});

  final int? matchNo;
  final String? team1Cover;
  final String? team2Cover;
  final String? team1Name;
  final String? team2Name;
  final int? team1Goal;
  final int? team2Goal;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromRGBO(228, 229, 229, 1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            "Match $matchNo",
            style: const TextStyle(
              color: AppColors.black,
              fontFamily: "Lato",
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width:size.width /3,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.grey,
                      backgroundImage: NetworkImage(
                        team1Cover == null || team1Cover!.isEmpty
                            ? AppProfilesCover.clubCover
                            : team1Cover!,
                      ),
                      radius: 24,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      team1Name ?? "Team A",
                      style: const TextStyle(
                        color: AppColors.black,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width:size.width /5,
                child: Text(
                  '${team1Goal == -1 || team1Goal == null ? "" : team1Goal} - ${team2Goal == -1 || team2Goal == null ? "" : team2Goal}',
                  style: const TextStyle(
                    color: AppColors.black,
                    fontFamily: "SFUIDisplay",
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width:size.width /3,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.grey,
                      backgroundImage: NetworkImage(
                        team2Cover == null || team2Cover!.isEmpty
                            ? AppProfilesCover.clubCover
                            : team2Cover!,
                      ),
                      radius: 24,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      team2Name ?? "Team B",
                      style: const TextStyle(
                        color: AppColors.black,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
