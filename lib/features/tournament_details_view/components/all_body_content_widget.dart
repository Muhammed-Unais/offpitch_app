import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/components/club_profile_name.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import '../model/single_tournament_model.dart';
import 'tournament_about.dart';
import 'tournament_data_place.dart';
import 'registered_teams.dart';
import 'short_description.dart';
import 'tournament_profile.dart';
import 'package:offpitch_app/features/tournament_details_view/components/registration_components/registration_status.dart';

class AllBodyContentWidget extends StatelessWidget {
  const AllBodyContentWidget({
    super.key,
    required this.data,
    required this.size,
    required this.teams,
    required this.singleTournamentModel,
  });

  final TournamentDetailsData? data;
  final Size size;
  final List<DataTeam>? teams;
  final SingleTournamentModel? singleTournamentModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ClubProfileNameWidget(
          clubImage: data?.host?.profile ?? AppProfilesCover.clubCover,
          clubName: data?.host?.name ?? "",
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            data?.title ?? "",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
            overflow: TextOverflow.clip,
          ),
        ),
        const SizedBox(height: 20),
        TournamentProfile(
          image: data?.cover ?? AppProfilesCover.clubCover,
          hight: size.height * 0.2,
          width: size.width,
        ),
        const SizedBox(
          height: 20,
        ),
        ShortDescription(
          shortDescription: data?.shortDescription,
        ),
        const SizedBox(height: 20),
        TournamentDatePlace(
          place: data?.location ?? "",
          date: data?.startDate ?? "",
          hight: 42,
          width: 42,
          dateIcon: Icons.calendar_month,
          placeIcon: Icons.place_outlined,
        ),
        const SizedBox(height: 20),
        const Divider(
          thickness: 0.5,
          color: AppColors.grey,
        ),
        const SizedBox(height: 20),
        RegistrationStatusWidget(
          data: singleTournamentModel!,
        ),
        teams!.isEmpty
            ? const EmptyComponentPng(
                errorMessage: "No Registration",
                imagePath: "assets/images/No data-cuate.png",
                hight: 100,
                width: 100,
              )
            : RegisteredTeams(
                singleTourdata: singleTournamentModel,
              ),
        const SizedBox(height: 20),
        TournamentAboutWidget(
          data: singleTournamentModel!,
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Text(
              data?.host?.email ?? "",
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              data?.host?.phone?.toString() ?? "",
              style: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: "Lato",
              ),
            ),
            const SizedBox(height: 20),
          ],
        )
      ],
    );
  }
}