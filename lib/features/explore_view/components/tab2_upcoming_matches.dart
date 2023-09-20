import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/features/explore_view/model/all_tournaments_model.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/features/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class ExploreTournaments extends StatelessWidget {
  const ExploreTournaments({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<ExploreViewViewModel>(
      builder: (context, value, child) {
        Status? status;
        int? length;
        List<AllTournament>? tournaments;

        switch (value.exploretournaments) {
          case Exploretournaments.all:
            status = value.allTournaments.status;
            length = value.allTournaments.data?.length;
            tournaments = value.allTournaments.data?.reversed.toList();
            break;
          case Exploretournaments.live:
            status = value.liveTournaments.status;
            length = value.liveTournaments.data?.length;
            tournaments = value.liveTournaments.data?.reversed.toList();
            break;
          case Exploretournaments.upcoming:
            status = value.upcomingTournaments.status;
            length = value.upcomingTournaments.data?.length;
            tournaments = value.upcomingTournaments.data?.reversed.toList();
            break;
          default:
        }

        switch (status) {
          case Status.LOADING:
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: AppMargin.large,
              ),
              itemCount: length,
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
                  errorMessage: value.allTournaments.message ?? "",
                  hight: size.height * 0.15,
                  width: size.height * 0.15,
                )
              ],
            );
          case Status.COMPLETED:
            if (tournaments == null || tournaments.isEmpty) {
              return EmptyComponts(
                showMessage: "No Tournaments",
                image: "assets/images/no-data.svg",
                height: size.height * 0.15,
                width: size.height * 0.15,
                addText: "...",
              );
            }
            return ListView.builder(
              itemCount: tournaments.length,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                final tournament = tournaments?[index];
                return InkWell(
                  onTap: () async {
                    var tournametDetailsProvider =
                        context.read<DetailsTouramentViewModel>();
                    tournametDetailsProvider
                        .getSingleTournament(tournament?.id);
                    await Navigator.pushNamed(context, "tournamentdetails");
                  },
                  child: TournamentCard(
                    touranmentCoverImage:
                        tournament?.cover ?? AppProfilesCover.clubCover,
                    tornamentName: tournament?.title ?? "No title",
                    tornamentPlace: tournament?.location ?? "",
                    tornamentDate: tournament?.startDate ?? "",
                    shortDescription: tournament?.shortDescription ?? "",
                  ),
                );
              },
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
