import 'package:flutter/material.dart';
import 'package:offpitch_app/src/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/src/home_view/components/home_body.dart';
import 'package:offpitch_app/src/home_view/components/home_create_tournament_icon.dart';
import 'package:offpitch_app/src/home_view/components/home_titile_widget.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/home_view/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeViewModel>().homeTournamentsChip = HomeTournamentsEnum.all;
    fetchUserDetails();
    super.initState();
  }

  void fetchUserDetails() async {
    var exploreAndSearchProvider = context.read<ExploreViewViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (exploreAndSearchProvider.allTournaments.data == null ||
          exploreAndSearchProvider.liveTournaments.data == null) {
       
        exploreAndSearchProvider.getExpAndSrchTournmts(
            query: 'filter=all', sortingQuery: "all");
      }
      if (exploreAndSearchProvider.upcomingTournaments.data == null) {
        exploreAndSearchProvider.getExpAndSrchTournmts(
            query: 'filter=all', sortingQuery: "upcoming");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HomeTitleWidget(),
        actions: const [HomeCreateTournamentIcon()],
        centerTitle: false,
      ),
      backgroundColor: AppColors.white,
      body: const SafeArea(
        child: HomeBody(),
      ),
    );
  }
}
