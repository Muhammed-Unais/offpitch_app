import 'package:flutter/material.dart';
import 'package:offpitch_app/src/tournament_details/components/club_profile_name.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/single_tournament_model.dart';
import 'tournament_about.dart';
import 'tournament_data_place.dart';
import 'registered_teams.dart';
import 'short_description.dart';
import 'tournament_profile.dart';
import 'package:offpitch_app/src/tournament_details/components/registration_components/registration_status.dart';

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
          fontsize: 16,
          clubCover: ClipOval(
            child: FadeInImage(
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              placeholderFit: BoxFit.cover,
              placeholder: const AssetImage(
                AppProfilesCover.clubCover,
              ),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  AppProfilesCover.clubCover,
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                );
              },
              placeholderErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  height: 70,
                  width: 70,
                  AppProfilesCover.clubCover,
                );
              },
              image: NetworkImage(
                data?.host?.profile ?? "",
              ),
            ),
          ),
          clubName: data?.host?.name ?? "",
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            data?.title ?? "",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
            overflow: TextOverflow.clip,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                final uri = Uri(
                  scheme: "mailto",
                  path: data?.host?.email,
                  queryParameters: {'subject': "Subject"},
                );
                await launchUrl(uri);
              },
              child: Text(
                "Email:- ${data?.host?.email ?? ""}",
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontFamily: "Lato",
                ),
                overflow: TextOverflow.clip,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final uri = Uri(
                  scheme: "tel",
                  path: data?.host?.phone.toString(),
                );
                if (await canLaunchUrl(uri)) {
                  launchUrl(uri);
                }
              },
              child: Text(
                "Phone:- ${data?.host?.phone?.toString() ?? ""}",
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontFamily: "Lato",
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ],
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
      ],
    );
  }
}
