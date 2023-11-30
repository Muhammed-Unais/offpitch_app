import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/explore/model/all_tournaments_model.dart';
import 'package:offpitch_app/res/components/empty_components.dart';
import 'package:offpitch_app/res/components/error_component.dart';
import 'package:offpitch_app/res/components/shimer_effects.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/src/explore/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/src/tournament_details/view_model/tournament_detils_view_model.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class ExploreAllTournaments extends StatefulWidget {
  const ExploreAllTournaments({super.key});

  @override
  State<ExploreAllTournaments> createState() => _ExploreAllTournamentsState();
}

class _ExploreAllTournamentsState extends State<ExploreAllTournaments> {
  final ScrollController _scrollController = ScrollController();

  int _page = 1;

  List<AllTournament>? allTournaments;

  bool isLimit = false;

  @override
  void didChangeDependencies() {
    listenScrollControllor();
    super.didChangeDependencies();
  }

  void listenScrollControllor() {
    var exploreProvider = context.read<ExploreViewViewModel>();

    _scrollController.addListener(() async {
      if (allTournaments != null &&
          allTournaments!.length >= exploreProvider.allTournamentCount) {
        isLimit = true;
        if (mounted) {
          setState(() {});
        }
        return;
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page += 1;
        await pickUpInpagination();
      }
    });
  }

  Future<void> pickUpInpagination() async {
    var exploreProvider = context.read<ExploreViewViewModel>();
    var newTournaments = await exploreProvider.paginationAllandLiveTournaments(
        query: "page=$_page");
    allTournaments = allTournaments! + newTournaments;
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<ExploreViewViewModel>(
      builder: (context, value, child) {
        Status? status;

        allTournaments ??= value.allTournaments.data;

        status = value.allTournaments.status;

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
                  errorMessage: value.allTournaments.message ?? "",
                  hight: size.height * 0.15,
                  width: size.height * 0.15,
                )
              ],
            );
          case Status.COMPLETED:
            if (allTournaments == null || allTournaments!.isEmpty) {
              return EmptyComponts(
                showMessage: "No Tournaments",
                image: "assets/images/no-data.svg",
                height: size.height * 0.15,
                width: size.height * 0.15,
                addText: "...",
              );
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              child: Column(
                children: [
                  ListView.builder(
                    primary: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allTournaments?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final tournament = allTournaments?[index];
                      return GestureDetector(
                        onTap: () async {
                          var tournametDetailsProvider =
                              context.read<DetailsTouramentViewModel>();
                          tournametDetailsProvider
                              .getSingleTournament(tournament?.id);
                          await Navigator.pushNamed(
                              context, RoutesName.tournamentDetails);
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
                  if (!isLimit)
                    const Center(
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    )
                ],
              ),
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
