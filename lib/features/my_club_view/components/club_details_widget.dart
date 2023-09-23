import 'package:flutter/material.dart';
import 'package:offpitch_app/features/my_club_view/components/tabview_one_club_description.dart';
import 'package:offpitch_app/features/my_club_view/components/tabview_one_club_profile.dart';
import 'package:offpitch_app/features/my_club_view/model/club_tournamentmodel.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'my_club_players.dart';

class ClubDetailsWidget extends StatelessWidget {
  const ClubDetailsWidget({
    super.key,
    required this.data,
  });

  final ClubTournamentModel? data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding:
                EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child: Text(
              "CLUB PLAYERS",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.grey,
              ),
            ),
          ),
          const MyClubPlayers(),
          const Divider(
            color: AppColors.grey,
            thickness: 0.4,
          ),
          const SizedBox(
            height: 10,
          ),
          TabViewOneClubProfile(
            clubName: data?.data?.name ?? "No title",
            image:
                data?.data?.profile ?? AppProfilesCover.clubCover,
            playerCount: data?.data?.players.length ?? 0,
          ),
          const SizedBox(
            height: 20,
          ),
          TabViewOneClubDescription(
            phone: data?.data?.phone ?? 91,
            email: data?.data?.email ?? "",
            createdAt: data?.data?.createdAt,
            updatedAt: data?.data?.updatedAt,
            description:
                data?.data?.description ?? "No description",
          ),
        ],
      ),
    );
  }
}