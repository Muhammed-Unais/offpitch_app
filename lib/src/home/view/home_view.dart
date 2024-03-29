import 'package:flutter/material.dart';
import 'package:offpitch_app/src/explore/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/src/home/components/home_body.dart';
import 'package:offpitch_app/src/home/components/home_create_tournament_icon.dart';
import 'package:offpitch_app/src/home/components/home_titile_widget.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/home/view_model/home_view_model.dart';
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
