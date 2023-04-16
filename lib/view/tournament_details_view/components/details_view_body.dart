import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_club_name.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_data_place.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_short_description.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_timer_remaining.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_tournament_image.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_tournament_name.dart';
import 'package:offpitch_app/view_model/torunament_details_timer_view_model.dart';
import 'package:offpitch_app/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final details = Provider.of<DetailsTouramentViewModel>(context);
    final data = details.detailsTournament.data;
    return SingleChildScrollView(
      child: Column(
        children: [
          DetailsViewClubName(
            clubImage: data!.cover,
            clubName: data.host.name,
          ),
          DetailsViewTournamentName(tournamentName: data.title),
          DetailsViewTournamentImage(
            image: data.cover,
            hight: size.height * 0.25,
            width: size.width,
          ),
          DetailsViewShortDescription(shortDescription: data.shortDescription),
          DetailsViewDateTime(
            place: data.location,
            date: data.startDate,
            hight: 44,
            width: 44,
            dateIcon: Icons.calendar_month,
            placeIcon: Icons.place_outlined,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppMargin.large,
              vertical: AppMargin.large,
            ),
            child: Divider(
              thickness: 0.5,
              color: AppColors.grey,
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => TournamentProvider(),
            child: Consumer<TournamentProvider>(
              builder: (context, value, child) {
                Duration remainingTime = Duration.zero;
                DateTime tournamentStartingDate =
                    DateFormat("dd MMM yyyy").parse(data.startDate);
                remainingTime =
                    tournamentStartingDate.difference(DateTime.now());
                if (remainingTime.isNegative) {
                  return const Text("Registration closed");
                }
                value.calculateRemainingTime(tournamentStartingDate);
                return DetailsViewTimerRemain(
                  height: size.height * 0.12,
                  width: size.width,
                  days: value.remainingTime.inDays.toString(),
                  hours: (value.remainingTime.inHours % 24).toString(),
                  minuts: (value.remainingTime.inMinutes % 60).toString(),
                  seconds: (value.remainingTime.inSeconds % 60).toString(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
