import 'package:flutter/material.dart';
import 'package:offpitch_app/src/tournament_schedule.dart/components/league_results/league_match_tab_view.dart';
import 'package:offpitch_app/src/tournament_schedule.dart/components/league_results/league_teams_tab_view_two.dart';
import 'package:offpitch_app/src/tournament_details/model/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class LeagueTournamentT1 extends StatefulWidget {
  const LeagueTournamentT1({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  State<LeagueTournamentT1> createState() => _LeagueTournamentT1State();
}

class _LeagueTournamentT1State extends State<LeagueTournamentT1>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: AppMargin.small),
                width: size.width * 0.2,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppRadius.borderRadiusS,
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.singleTournamentModel.data?.cover ?? "",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                widget.singleTournamentModel.data?.title ?? "No title",
                style: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                overflow: TextOverflow.clip,
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Divider(
            thickness: 0.5,
            color: AppColors.grey,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              labelStyle: const TextStyle(
                color: AppColors.black,
                fontFamily: "Lato",
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              unselectedLabelColor: AppColors.black,
              labelColor: AppColors.primary,
              splashFactory: NoSplash.splashFactory,
              indicatorColor: Colors.transparent,
              labelPadding: const EdgeInsets.only(left: 0, right: 20),
              isScrollable: true,
              controller: tabController,
              tabs: const [
                Tab(
                  text: "MATCH",
                ),
                Tab(
                  text: "TEAMS",
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              LeagueMatchTabView(
                singleTournamentModel: widget.singleTournamentModel,
              ),
              // Table Scroll Table
              LeagueTeamsTabViewTwo(
                singleTournamentModel: widget.singleTournamentModel,
              )
            ],
          ),
        )
      ],
    );
  }
}
