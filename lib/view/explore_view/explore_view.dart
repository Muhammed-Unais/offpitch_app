import 'package:flutter/material.dart';
import 'package:offpitch_app/view/explore_view/components/explore_search.dart';
import 'package:offpitch_app/view/explore_view/components/explore_tabbar.dart';
import 'package:offpitch_app/view/explore_view/components/tab1_today_matches.dart';
import 'package:offpitch_app/view/explore_view/components/tab2_upcoming_matches.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/explore_view_view_model.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      context
          .read<ExploreViewViewModel>()
          .setSearchTabbarIndex(tabController.index);
      context
          .read<ExploreViewViewModel>()
          .getExpAndSrchTournmts(query: 'filter=all', sortingQuery: "all");
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 1,
          title: const Text('Tournaments'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(
              80,
            ),
            child: ExploreSearch(controller: tabController),
          ),
        ),
        body: Column(
          children: [
            ExploreTabBar(tabController: tabController),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  Tab1TodayMatches(),
                  Tab2UpcomingMatches(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
