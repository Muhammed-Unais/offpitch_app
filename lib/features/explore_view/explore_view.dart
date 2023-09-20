import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/search_component.dart';
import 'package:offpitch_app/features/explore_view/components/explore_tabbar.dart';
import 'package:offpitch_app/features/explore_view/components/tab1_today_matches.dart';
import 'package:offpitch_app/features/explore_view/components/tab2_upcoming_matches.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:provider/provider.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key, required this.searchQuery});

  final String searchQuery;

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    log(widget.searchQuery);
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      context.read<ExploreViewViewModel>().setSearchTabbarIndex(
            tabController.index,
          );
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var exploreAndSearchProvider = context.read<ExploreViewViewModel>();
      if (exploreAndSearchProvider.allTournaments.data == null &&
          exploreAndSearchProvider.liveTournaments.data == null) {
        exploreAndSearchProvider.getExpAndSrchTournmts(
          query: 'filter=all',
          sortingQuery: "all",
        );
      }
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
          title: const Text("Tournaments"),
          backgroundColor: Colors.white,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: SearchWidget(),
              )
            ];
          },
          body: Column(
            children: [
              ExploreTabBar(
                tabController: tabController,
                firstTab: "Today Matches",
                secondTab: "Tournaments",
              ),
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
      ),
    );
  }
}
