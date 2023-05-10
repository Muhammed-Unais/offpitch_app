import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/styles/constats.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/explore_view_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class Tab1TodayMatches extends StatelessWidget {
  const Tab1TodayMatches({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ExploreViewViewModel>(
      builder: (context, value, child) {
        switch (value.liveTournaments.status) {
          case Status.LOADING:
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: AppMargin.large,
              ),
              itemCount: value.liveTournaments.data?.length,
              itemBuilder: (context, index) {
                return ShimerWidget.rectangular(
                  borderRadius: AppRadius.borderRadiusM,
                  verticalMargin: AppMargin.small,
                  hight: size.height * 0.2,
                );
              },
            );
          case Status.ERROR:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: AppMargin.large,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: AppMargin.small),
                  height: 150,
                  width: 150,
                  child: SvgPicture.asset(
                    "assets/images/no-data.svg",
                  ),
                ),
                Text(
                  value.liveTournaments.message ?? "",
                ),
              ],
            );
          case Status.COMPLETED:
            final allTournamentdata = value.liveTournaments.data;
            if (allTournamentdata==null|| allTournamentdata.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: AppMargin.small),
                    height: 150,
                    width: 150,
                    child: SvgPicture.asset(
                      "assets/images/no-data.svg",
                    ),
                  ),
                  Text(
                    "Today No Tournaments",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              );
            }
            return ListView.builder(
              itemCount: allTournamentdata.length,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                final tournaments = allTournamentdata[index];
                return InkWell(
                  onTap: () async {
                    Provider.of<DetailsTouramentViewModel>(context,
                            listen: false)
                        .getSingleTournament(tournaments.id);
                    await Navigator.pushNamed(context, "tournamentdetails");
                  },
                  child: TournamentCard(
                    touranmentCoverImage: tournaments.cover,
                    tornamentName: tournaments.title,
                    tornamentPlace: tournaments.location,
                    tornamentDate: tournaments.startDate,
                    shortDescription: tournaments.shortDescription,
                  ),
                );
              },
            );
          default:
            return Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: SvgPicture.asset(
                  "assets/images/no-data.svg",
                ),
              ),
            );
        }
      },
    );
  }
}
