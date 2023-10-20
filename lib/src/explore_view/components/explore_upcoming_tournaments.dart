import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/src/explore_view/model/all_tournaments_model.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/src/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class ExploreUpcomingTournaments extends StatelessWidget {
  const ExploreUpcomingTournaments({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<ExploreViewViewModel>(
      builder: (context, value, child) {
        Status? status;
        List<AllTournament>? upcomingTournament;

        status = value.upcomingTournaments.status;
        upcomingTournament = value.upcomingTournaments.data;

        switch (status) {
          case Status.LOADING:
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: AppMargin.large,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ShimerWidget.rectangular(
                  borderRadius: AppRadius.borderRadiusS,
                  verticalMargin: AppMargin.small,
                  hight: size.height * 0.15,
                );
              },
            );
          case Status.ERROR:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ErrorComponent(
                  errorMessage: value.upcomingTournaments.message ?? "",
                  hight: size.height * 0.15,
                  width: size.height * 0.15,
                )
              ],
            );
          case Status.COMPLETED:
            if (upcomingTournament == null || upcomingTournament.isEmpty) {
              return EmptyComponts(
                showMessage: "No Tournaments",
                image: "assets/images/no-data.svg",
                height: size.height * 0.15,
                width: size.height * 0.15,
                addText: "...",
              );
            }
            return Column(
              children: [
                ListView.builder(
                  itemCount: upcomingTournament.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final tournament = upcomingTournament?[index];
                    return GestureDetector(
                      onTap: () async {
                        var tournametDetailsProvider =
                            context.read<DetailsTouramentViewModel>();
                        tournametDetailsProvider
                            .getSingleTournament(tournament?.id);
                        await Navigator.pushNamed(
                          context,
                          RoutesName.tournamentDetails,
                        );
                      },
                      child: TournamentCard(
                        coverUrl: tournament?.cover,
                        tornamentName: tournament?.title ?? "No title",
                        tornamentPlace: tournament?.location ?? "",
                        tornamentDate: tournament?.startDate ?? "",
                        shortDescription: tournament?.shortDescription ?? "",
                      ),
                    );
                  },
                ),
              ],
            );
          default:
            return Center(
              child: SizedBox(
                height: size.height * 0.15,
                width: size.height * 0.15,
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
