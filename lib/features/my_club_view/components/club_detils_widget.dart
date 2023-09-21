import 'package:flutter/material.dart';
import 'package:offpitch_app/features/my_club_view/components/tabview_one_club_description.dart';
import 'package:offpitch_app/features/my_club_view/components/tabview_one_club_profile.dart';
import 'package:offpitch_app/features/my_club_view/components/tav_view_one_email_phone.dart';
import 'package:offpitch_app/features/my_club_view/model/club_tournamentmodel.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class ClubDetailsWidget extends StatelessWidget {
  const ClubDetailsWidget({
    super.key,
    required this.size,
    required this.data,
  });

  final Size size;
  final ClubTournamentModel? data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.48,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabViewOneClubProfile(
            clubName: data?.data?.name ?? "No title",
            image: data?.data?.profile ?? AppProfilesCover.clubCover,
            playerCount: data?.data?.players.length ?? 0,
          ),
          Expanded(
            child: TabViewOneClubDescription(
              createdAt: data?.data?.createdAt,
              updatedAt: data?.data?.updatedAt,
              description: data?.data?.description ?? "No description",
            ),
          ),
          TabbarViewOneEmailPhone(
            hight: size.height * 0.08,
            email: data?.data?.email ?? "No email",
            phone: data?.data?.phone ?? 0,
          ),
          const Divider(
            thickness: 0.5,
            color: AppColors.grey,
          ),
        ],
      ),
    );
  }
}
