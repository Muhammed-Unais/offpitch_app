import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/scheduled_about_tab_view.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/knock_results/knockout_tournament_t2.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/scheduled_view_tabbar.dart';
import 'components/league_results/league_tournament_t1.dart';

class ScheduledView extends StatefulWidget {
  const ScheduledView({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  State<ScheduledView> createState() => _ScheduledViewState();
}

class _ScheduledViewState extends State<ScheduledView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          ScheduledViewTabbar(
            tabController: tabController,
          ),
          const SizedBox(
            height:20,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                widget.singleTournamentModel.data?.tournamentType == "t2"
                    ? KnockOutTournamentT2(
                        singleTournamentModel: widget.singleTournamentModel,
                      )
                    : LeagueTournamentT1(
                        singleTournamentModel: widget.singleTournamentModel,
                      ),
                ScheduledAboutTabView(
                  singleTournamentModel: widget.singleTournamentModel,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
