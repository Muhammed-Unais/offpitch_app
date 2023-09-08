import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_about.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_data_place.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_short_description.dart';

class ScheduledTabbarTwo extends StatelessWidget {
  const ScheduledTabbarTwo({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppMargin.large),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(),
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
                width: AppMargin.small,
              ),
              Text(
                textAlign: TextAlign.center,
                singleTournamentModel.data?.title ?? "",
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
          const SizedBox(
            height: AppMargin.large,
          ),
          DetailsViewShortDescription(
              shortDescription:
                  singleTournamentModel.data?.shortDescription ?? ""),
          const SizedBox(
            height: AppMargin.large,
          ),
          DetailsViewDateTime(
            date: singleTournamentModel.data?.startDate ?? "",
            dateIcon: Icons.date_range,
            hight: 44,
            width: 44,
            place: singleTournamentModel.data?.location ?? "",
            placeIcon: Icons.location_on,
          ),
          DetailsViewAbout(
            data: singleTournamentModel,
          )
        ],
      ),
    );
  }
}
