import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view/tournament_details_view/details_view_schedule_view.dart/components/details_view_schedule_table_score.dart';

class DetailsViewScheduledViewTabbarT1 extends StatefulWidget {
  const DetailsViewScheduledViewTabbarT1(
      {super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  State<DetailsViewScheduledViewTabbarT1> createState() =>
      _DetailsViewScheduledViewTabbarT1State();
}

class _DetailsViewScheduledViewTabbarT1State
    extends State<DetailsViewScheduledViewTabbarT1>
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
          margin:const EdgeInsets.symmetric(horizontal: AppMargin.large),
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
                      widget.singleTournamentModel.data!.cover!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                widget.singleTournamentModel.data!.title!,
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
        const SizedBox(
          height: AppMargin.large,
        ),
        Container(
           margin:const EdgeInsets.symmetric(horizontal: AppMargin.large),
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
          child: Container(
             margin:const EdgeInsets.symmetric(horizontal: AppMargin.large),
            child: TabBarView(
          
              controller: tabController,
              children:  const [
                Center(
                  child: Text(""),
                ),
                FootballScoreTable()
              ],
            ),
          ),
        )
      ],
    );
  }
}
