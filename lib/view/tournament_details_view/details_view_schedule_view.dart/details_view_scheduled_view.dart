import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/tournament_details_view/details_view_schedule_view.dart/components/details_view_scheduled_view_tabbar.dart';
import 'package:offpitch_app/view/tournament_details_view/details_view_schedule_view.dart/components/details_view_scheduled_view_tabbar1.dart';

class DetailsViewScheduledView extends StatefulWidget {
  const DetailsViewScheduledView(
      {super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  State<DetailsViewScheduledView> createState() =>
      _DetailsViewScheduledViewState();
}

class _DetailsViewScheduledViewState extends State<DetailsViewScheduledView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: AppMargin.large, horizontal: AppMargin.large),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          DetailsTournamentScheduledViewTabbar(
            tabController: tabController,
          ),
          const SizedBox(
            height: AppMargin.large,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                DetailsViewScheduledViewTabbar(
                  singleTournamentModel: widget.singleTournamentModel,
                ),
                const Text("")
              ],
            ),
          )
        ],
      ),
    );
  }
}
