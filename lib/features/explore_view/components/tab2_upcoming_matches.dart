import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class Tab2UpcomingMatches extends StatelessWidget {
  const Tab2UpcomingMatches({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tournametDetailsProvider =
        Provider.of<DetailsTouramentViewModel>(context, listen: false);
    return Consumer<ExploreViewViewModel>(
      builder: (context, value, child) {
        switch (value.allTournaments.status) {
          case Status.LOADING:
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: AppMargin.large,
              ),
              itemCount: value.allTournaments.data?.length,
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
                ErrorComponent(errorMessage: value.allTournaments.message ?? "")
              ],
            );
          case Status.COMPLETED:
            final allTournamentdata =
                value.allTournaments.data?.reversed.toList();
            if (allTournamentdata == null || allTournamentdata.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ErrorComponent(errorMessage: "No Tournaments")
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
                    tournametDetailsProvider
                        .getSingleTournament(tournaments.id);
                    await Navigator.pushNamed(context, "tournamentdetails");
                  },
                  child: TournamentCard(
                    touranmentCoverImage:
                        tournaments.cover ?? AppProfilesCover.clubCover,
                    tornamentName: tournaments.title ?? "No title",
                    tornamentPlace: tournaments.location ?? "",
                    tornamentDate: tournaments.startDate ?? "",
                    shortDescription: tournaments.shortDescription ?? "",
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
