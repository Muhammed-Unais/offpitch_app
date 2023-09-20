import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/features/explore_view/model/all_tournaments_model.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/features/home_view/view_model/home_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class HomeAllTournaments extends StatelessWidget {
  const HomeAllTournaments({
    super.key,
    required this.size,
    required this.homeTournaments,
  });

  final Size size;
  final HomeTournamentsEnum homeTournaments;

  @override
  Widget build(BuildContext context) {
    return Consumer<ExploreViewViewModel>(
      builder: (context, exploreViewModel, child) {
        int? toruanmentLength;
        Status? fetchinStatus;

        if (homeTournaments == HomeTournamentsEnum.all) {
          toruanmentLength = exploreViewModel.allTournaments.data?.length;
          fetchinStatus = exploreViewModel.allTournaments.status;
        }
        if (homeTournaments == HomeTournamentsEnum.live) {
          toruanmentLength = exploreViewModel.liveTournaments.data?.length;
          fetchinStatus = exploreViewModel.liveTournaments.status;
        }
        if (homeTournaments == HomeTournamentsEnum.upcoming) {
          toruanmentLength = exploreViewModel.upcomingTournaments.data?.length;
          fetchinStatus = exploreViewModel.upcomingTournaments.status;
        }

        switch (fetchinStatus) {
          case Status.LOADING:
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return ShimerWidget.rectangular(
                  borderRadius: AppRadius.borderRadiusS,
                  verticalMargin: AppMargin.small,
                  hight: size.height * 0.15,
                );
              },
            );

          case Status.COMPLETED:
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              itemCount: toruanmentLength! > 3 ? 3 : toruanmentLength,
              itemBuilder: (context, index) {
                AllTournament? tournaments;
                if (homeTournaments == HomeTournamentsEnum.all) {
                  tournaments = exploreViewModel.allTournaments.data?.reversed
                      .toList()[index];
                }
                if (homeTournaments == HomeTournamentsEnum.live) {
                  tournaments = exploreViewModel.liveTournaments.data?.reversed
                      .toList()[index];
                }
                if (homeTournaments == HomeTournamentsEnum.upcoming) {
                  tournaments = exploreViewModel
                      .upcomingTournaments.data?.reversed
                      .toList()[index];
                }

                return GestureDetector(
                  onTap: () async {
                    var provider = context.read<DetailsTouramentViewModel>();
                    provider.getSingleTournament(tournaments?.id);
                    await Navigator.pushNamed(
                        context, RoutesName.tournamentDetails);
                  },
                  child: TournamentCard(
                    shortDescription: tournaments?.shortDescription,
                    touranmentCoverImage: tournaments?.cover ?? "",
                    tornamentName: tournaments?.title ?? "",
                    tornamentPlace: tournaments?.location ?? "",
                    tornamentDate: tournaments?.startDate ?? "",
                  ),
                );
              },
            );

          case Status.ERROR:
            return SizedBox(
              height: size.height * 0.35,
              child: Center(
                child: ErrorComponent(
                  width: size.height * 0.15,
                  hight: size.height * 0.15,
                  errorMessage: exploreViewModel.allTournaments.message ?? "",
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
