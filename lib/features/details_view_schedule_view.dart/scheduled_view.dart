import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/schedule_tabbar_two.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/scheduled_view_t2.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/scheduled_view_tabbar.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/scheduled_view_tabbar1.dart';

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
                    ? ScheduledviewT2(
                        singleTournamentModel: widget.singleTournamentModel,
                      )
                    : ScheduledViewTabbarT1(
                        singleTournamentModel: widget.singleTournamentModel,
                      ),
                ScheduledTabbarTwo(
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
