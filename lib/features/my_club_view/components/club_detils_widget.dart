import 'package:flutter/material.dart';
import 'package:offpitch_app/features/my_club_view/components/tabview_one_club_description.dart';
import 'package:offpitch_app/features/my_club_view/components/tabview_one_club_profile.dart';
import 'package:offpitch_app/features/my_club_view/model/club_tournamentmodel.dart';
import 'package:offpitch_app/res/constats.dart';

class ClubDetailsWidget extends StatelessWidget {
  const ClubDetailsWidget({
    super.key,
    required this.data,
  });

  final ClubTournamentModel? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabViewOneClubProfile(
          clubName: data?.data?.name ?? "No title",
          image: data?.data?.profile ?? AppProfilesCover.clubCover,
          playerCount: data?.data?.players.length ?? 0,
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: TabViewOneClubDescription(
            phone: data?.data?.phone ?? 91,
            email: data?.data?.email ?? "",
            createdAt: data?.data?.createdAt,
            updatedAt: data?.data?.updatedAt,
            description: data?.data?.description ?? "No description",
          ),
        ),
      ],
    );
  }
}
