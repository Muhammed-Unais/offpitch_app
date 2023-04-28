import 'package:flutter/material.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class DetailsViewScheduledViewTabbar extends StatefulWidget {
  const DetailsViewScheduledViewTabbar(
      {super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  State<DetailsViewScheduledViewTabbar> createState() =>
      _DetailsViewScheduledViewTabbarState();
}

class _DetailsViewScheduledViewTabbarState
    extends State<DetailsViewScheduledViewTabbar>
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(
          height: AppMargin.large,
        ),
        Align(
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
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              Center(
                child: Text(""),
              ),
              Text("sss"),
            ],
          ),
        )
      ],
    );
  }
}
