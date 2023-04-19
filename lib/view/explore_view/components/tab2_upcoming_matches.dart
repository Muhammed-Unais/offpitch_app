import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/res/components/tournament_card.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/home_and_exp_view_model.dart';
import 'package:offpitch_app/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class Tab2UpcomingMatches extends StatefulWidget {
  const Tab2UpcomingMatches({super.key});

  @override
  State<Tab2UpcomingMatches> createState() => _Tab2UpcomingMatchesState();
}

class _Tab2UpcomingMatchesState extends State<Tab2UpcomingMatches> {
  HomeAndExpViewModel homeViewModel = HomeAndExpViewModel();
  @override
  void initState() {
    homeViewModel.getAllTournaments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeAndExpViewModel>(
      create: (context) => homeViewModel,
      child: Consumer<HomeAndExpViewModel>(
        builder: (context, value, child) {
          switch (value.upcomingTournament.status) {
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
                    value.allTournamentModel.message!,
                  ),
                ],
              );
            case Status.COMPLETED:
              if (value.upcomingTournament.data!.isEmpty) {
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
                itemCount: value.upcomingTournament.data!.length,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  final tournaments = value.upcomingTournament.data![index];
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
      ),
    );
  }
}
