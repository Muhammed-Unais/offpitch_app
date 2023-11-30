import 'package:flutter/material.dart';
import 'package:offpitch_app/src/tournament_details/components/club_profile_name.dart';
import 'package:offpitch_app/src/tournament_details/model/single_tournament_model.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/tournament_details/components/tournament_about.dart';
import 'package:offpitch_app/src/tournament_details/components/tournament_data_place.dart';
import 'package:offpitch_app/src/tournament_details/components/short_description.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ScheduledAboutTabView extends StatelessWidget {
  const ScheduledAboutTabView({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  Widget build(BuildContext context) {
    final data = singleTournamentModel.data;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      singleTournamentModel.data?.cover ?? "",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                singleTournamentModel.data?.title ?? "",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          const SizedBox(height: 20),
          ClubProfileNameWidget(
            fontsize: 12,
            clubCover: ClipOval(
             
              child: FadeInImage(
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                placeholderFit: BoxFit.cover,
                placeholder: const AssetImage(
                  AppProfilesCover.clubCover,
                ),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppProfilesCover.clubCover,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  );
                },
                placeholderErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    height: 50,
                    width: 50,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  final data = singleTournamentModel.data;
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
                  final data = singleTournamentModel.data;

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
          ShortDescription(
              shortDescription:
                  singleTournamentModel.data?.shortDescription ?? ""),
          const SizedBox(height: 20),
          TournamentDatePlace(
            date: singleTournamentModel.data?.startDate ?? "",
            dateIcon: Icons.date_range,
            hight: 44,
            width: 44,
            place: singleTournamentModel.data?.location ?? "",
            placeIcon: Icons.location_on,
          ),
          const SizedBox(height: 20),
          TournamentAboutWidget(
            data: singleTournamentModel,
          )
        ],
      ),
    );
  }
}
