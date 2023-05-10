import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/styles/constats.dart';

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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: AppColors.black,width: 0.1)
      ),
      elevation: 1,
      surfaceTintColor: AppColors.white,
      child: Column(
        children: [
          Text("Match $matchNo",
              style: Theme.of(context).textTheme.titleMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: size.width * 0.32,
                child: CircleAvatar(
                  backgroundColor: AppColors.grey,
                  backgroundImage: NetworkImage(
                    team1Cover == null || team1Cover!.isEmpty
                        ? 'https://www.gstatic.com/onebox/sports/logos/crest_48dp.png'
                        : team1Cover!,
                  ),
                  radius: 24,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.22,
                child: Text(
                  '${team1Goal == -1 || team1Goal == null ? "" : team1Goal} - ${team2Goal == -1 || team2Goal == null ? "" : team2Goal}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                width: size.width * 0.32,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.grey,
                      backgroundImage: NetworkImage(
                        team2Cover == null || team2Cover!.isEmpty
                            ? "https://www.gstatic.com/onebox/sports/logos/crest_48dp.png"
                            : team2Cover!,
                      ),
                      radius: 24,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: AppMargin.extraSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.32,
                child: Text(
                  team1Name ?? "Team A",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width * 0.32,
                child: Text(
                  team2Name ?? "Team B",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
