import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
// import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/view/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/view/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class Tab1TodayMatches extends StatefulWidget {
  const Tab1TodayMatches({super.key});

  @override
  State<Tab1TodayMatches> createState() => _Tab1TodayMatchesState();
}

class _Tab1TodayMatchesState extends State<Tab1TodayMatches> {
  // ScrollController scrollController = ScrollController();

  // int limit = 5;
  // // bool isLimit = false;

  // @override
  // void didChangeDependencies() {
  //   if (mounted) {
  //     scrollController.addListener(
  //       () {
  //         if (scrollController.position.pixels ==
  //             scrollController.position.maxScrollExtent) {
  //           limit += 5;
  //           setState(() {});
  //           todayTournamentsFetchingWithPagination();
  //         }
  //       },
  //     );
  //   }

  //   super.didChangeDependencies();
  // }

  // @override
  // void dispose() {
  //   scrollController.dispose();
  //   super.dispose();
  // }

  // Future<void> todayTournamentsFetchingWithPagination() async {
  //   var exploreViewModelProvider =
  //       Provider.of<ExploreViewViewModel>(context, listen: false);
  //   await exploreViewModelProvider.getExpAndSrchTournmts(
  //       query: "filter=all&$limit", sortingQuery: "all", isNotify: false);
  // }

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
                ErrorComponent(
                    errorMessage: value.liveTournaments.message ?? "")
              ],
            );
          case Status.COMPLETED:
            final allTournamentdata = value.liveTournaments.data;
            if (allTournamentdata == null || allTournamentdata.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ErrorComponent(errorMessage: "No Tournaments")
                ],
              );
            }
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allTournamentdata.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var tournaments = allTournamentdata[index];
                return InkWell(
                  onTap: () async {
                    context
                        .read<DetailsTouramentViewModel>()
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
                child: SvgPicture.asset("assets/images/no-data.svg"),
              ),
            );
        }
      },
    );
  }
}
