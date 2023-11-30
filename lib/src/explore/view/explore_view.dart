import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/search_container.dart';
import 'package:offpitch_app/src/explore/components/explore_all_tournament.dart';
import 'package:offpitch_app/src/explore/components/explore_live_all_tournament.dart';
import 'package:offpitch_app/src/explore/components/explore_upcoming_tournaments.dart';
import 'package:offpitch_app/res/components/tabbar_component.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/explore/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
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
    tabController = TabController(length: 3, vsync: this);
    fetchUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<void> fetchUserDetails() async {
    var exploreAndSearchProvider = context.read<ExploreViewViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (exploreAndSearchProvider.allTournaments.data == null ||
          exploreAndSearchProvider.liveTournaments.data == null) {
        exploreAndSearchProvider.getAllandLiveTournaments();
      }
      if (exploreAndSearchProvider.upcomingTournaments.data == null) {
        exploreAndSearchProvider.getUpComingTournaments();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "TOURNAMENTS",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.searchScreen);
                },
                child: const SearchContainer(),
              ),
            )
          ];
        },
        body: Column(
          children: [
            TabbarWidget(
              onTap: (value) {},
              hight: 50,
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 10,
                left: 20,
                right: 20,
              ),
              tabController: tabController,
              tabOne: "All",
              tabTwo: "Live",
              tabThree: "Upcoming",
              selectedTabColor: AppColors.black,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  ExploreAllTournaments(),
                  ExploreLiveTournaments(),
                  ExploreUpcomingTournaments(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
