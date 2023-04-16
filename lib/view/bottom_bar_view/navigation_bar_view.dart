
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/app_theme.dart';
import 'package:offpitch_app/view/create_tournament_view/create_tournament_view.dart';
import 'package:offpitch_app/view/explore_view/explore_view.dart';
import 'package:offpitch_app/view/home_view/home_view.dart';
import 'package:offpitch_app/view/my_club_view/my_club_view.dart';
import 'package:offpitch_app/view/user_details_view/user_deails_view.dart';
import 'package:offpitch_app/view_model/bottom_bar_viewmodel.dart';
import 'package:provider/provider.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  List views = [
    const HomeView(),
    const ExploreView(),
    const CreateTournamentView(),
    const MyClubView(),
    const UserDetailsView(),
  ];
  @override
  Widget build(BuildContext context) {
    final bottomBarVieModel = Provider.of<BottomBarViewModel>(context);
    return Scaffold(
      body: views[bottomBarVieModel.currentIndex],
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: bottomBarVieModel.onTap,
        currentIndex: bottomBarVieModel.currentIndex,
        iconSize: 24,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        backgroundColor: AppColors.white,
        elevation: 10,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              IconlyBold.home,
            ),  
          ),
          BottomNavigationBarItem(
            label: "Explore",
            icon: Icon(
              Icons.explore,
            ),
          ),
          BottomNavigationBarItem(
            label: "add",
            icon: Icon(
              Icons.add_circle,
              color: AppColors.primary,
              size: 36,
            ),
          ),
          BottomNavigationBarItem(
            label: "My Club",
            icon: Icon(
              Icons.sports_soccer_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: "Person",
            icon: Icon(
              IconlyBold.profile
            ),
          ),
        ],
      ),
    );
  }
}
