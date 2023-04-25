import 'package:flutter/material.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_scheduled_view_tabbar.dart';

class DetailsViewScheduledView extends StatelessWidget {
  const DetailsViewScheduledView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Schedule tournament",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(
              60,
            ),
            child: DetailsTournamentScheduledViewTabbar(),
          ),
        ),
      ),
    );
  }
}
