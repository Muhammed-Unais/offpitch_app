import 'package:flutter/material.dart';
import 'package:offpitch_app/features/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/scheduleview_t1_teams_tab.dart';
import 'package:offpitch_app/features/details_view_schedule_view.dart/components/schedule_view_t1_match_tab.dart';

class ScheduledViewTabbarT1 extends StatefulWidget {
  const ScheduledViewTabbarT1({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  State<ScheduledViewTabbarT1> createState() => _ScheduledViewTabbarT1State();
}

class _ScheduledViewTabbarT1State extends State<ScheduledViewTabbarT1>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.large),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: AppMargin.small),
                width: 80,
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
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
       const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppMargin.large,vertical: AppMargin.small),
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
              labelStyle: Theme.of(context).textTheme.labelLarge,
              unselectedLabelColor: AppColors.black,
              labelColor: AppColors.primary,
              splashFactory: NoSplash.splashFactory,
              indicatorColor: Colors.transparent,
              labelPadding: const EdgeInsets.only(left: 0, right: 20),
              isScrollable: true,
              controller: tabController,
              tabs: const [
                Tab(
                  text: "Match",
                ),
                Tab(
                  text: "Teams",
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              ScheduleViewT1MatchTab(
                singleTournamentModel: widget.singleTournamentModel,
              ),
              // Table Scroll Table
              ScheduleViewT1TeamsTab(
                singleTournamentModel: widget.singleTournamentModel,
              )
            ],
          ),
        )
      ],
    );
  }
}
