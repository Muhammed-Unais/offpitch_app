import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/components/details_view_club_name.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import '../model/single_tournament_model.dart';
import 'details_view_about.dart';
import 'details_view_data_place.dart';
import 'details_view_register.dart';
import 'details_view_registered_teams.dart';
import 'details_view_short_description.dart';
import 'details_view_tournament_image.dart';

class DetialsViewAllContentWidget extends StatelessWidget {
  const DetialsViewAllContentWidget({
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
        DetailsViewClubName(
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
        DetailsViewTournamentImage(
          image: data?.cover ?? AppProfilesCover.clubCover,
          hight: size.height * 0.2,
          width: size.width,
        ),
        const SizedBox(
          height: 20,
        ),
        DetailsViewShortDescription(
          shortDescription: data?.shortDescription,
        ),
        const SizedBox(height: 20),
        DetailsViewDateTime(
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
        DetailsViewRegister(
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
        DetailsViewAbout(
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