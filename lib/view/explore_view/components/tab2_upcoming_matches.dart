
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class Tab2UpcomingMatches extends StatelessWidget {
  const Tab2UpcomingMatches({super.key});

  @override
  
  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreViewViewModel>(
      builder: (context, value, child) {
        switch (value.allTournaments.status) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
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
                  value.allTournaments.message!,
                ),
              ],
            );
          case Status.COMPLETED:
            final allTournamentdata =
                value.allTournaments.data!.data.allTournaments;
            if (allTournamentdata.isEmpty) {
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
                    "No Tournaments",
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
                    final provider = Provider.of<DetailsTouramentViewModel>(
                        context,
                        listen: false);
                    provider.getSingleTournament(tournaments.id);
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
