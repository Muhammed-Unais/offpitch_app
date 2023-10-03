import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/tournament_details_view/components/tournament_about.dart';
import 'package:offpitch_app/features/tournament_details_view/components/tournament_data_place.dart';
import 'package:offpitch_app/features/tournament_details_view/components/short_description.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';

class ScheduledAboutTabView extends StatelessWidget {
  const ScheduledAboutTabView({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  Widget build(BuildContext context) {
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
                  borderRadius: BorderRadius.circular(
                    AppRadius.borderRadiusS,
                  ),
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
