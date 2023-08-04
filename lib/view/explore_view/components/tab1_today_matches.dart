import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/explore_view_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class Tab1TodayMatches extends StatefulWidget {
  const Tab1TodayMatches({super.key});

  @override
  State<Tab1TodayMatches> createState() => _Tab1TodayMatchesState();
}

class _Tab1TodayMatchesState extends State<Tab1TodayMatches> {
  ScrollController scrollController = ScrollController();
  
  int limit = 5;

  @override
  void didChangeDependencies() {
    if (mounted) {
        scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        limit += 5;
        todayTournamentsFetchingWithPagination();
      }
    });
    }
  
    super.didChangeDependencies();
  }
   @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> todayTournamentsFetchingWithPagination() async {
    final exploreViewModelProvider =
        Provider.of<ExploreViewViewModel>(context, listen: false);
    await exploreViewModelProvider.getExpAndSrchTournmts(
        query: "filter=all&$limit", sortingQuery: "all");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tournametDetailsProvider =
        Provider.of<DetailsTouramentViewModel>(context, listen: false);
    return Consumer<ExploreViewViewModel>(
      builder: (context, value, child) {
        switch (value.liveTournaments.status) {
          case Status.LOADING:
            return ListView.builder(
              controller: scrollController,
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
            return Column(
              children: [
                ListView.builder(
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
                ),
                 const CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 5,
                ),
              ],
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
