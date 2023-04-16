import 'package:flutter/material.dart';
import 'package:offpitch_app/view/explore_view/components/explore_search.dart';
import 'package:offpitch_app/view/explore_view/components/explore_tabbar.dart';
import 'package:offpitch_app/view/explore_view/components/tab1_today_matches.dart';
import 'package:offpitch_app/view/explore_view/components/tab2_upcoming_matches.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar.medium(floating: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Touranaments",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              // backgroundColor: AppColors.white,
            ),
          ];
        },
        body: Column(
          children: [
            const ExploreSearch(),
            ExploreTabBar(
              tabController: tabController,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [Tab1TodayMatches(), Tab2UpcomingMatches()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
