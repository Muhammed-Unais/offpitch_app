import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/explore_view/view/explore_view.dart';
import 'package:offpitch_app/src/home_view/view/home_view.dart';
import 'package:offpitch_app/src/my_club_view/view/my_club_view.dart';
import 'package:offpitch_app/src/user_profile_view/view/user_profile_view.dart';
import 'package:offpitch_app/src/bottom_bar_view/view_model/bottom_bar_viewmodel.dart';
import 'package:provider/provider.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  List<Widget> screens = [
    const HomeView(),
    const ExploreView(),
    const MyClubView(),
    const UserProfileView(),
  ];

  late PageController pageController;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomBarVieModel = Provider.of<BottomBarViewModel>(context);
    return Scaffold(
      body: screens[bottomBarVieModel.currentIndex],
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) =>
            bottomBarVieModel.onTap(value, context, controller: pageController),
        currentIndex: bottomBarVieModel.currentIndex,
        iconSize: 24,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        backgroundColor: AppColors.black,
        elevation: 10,
        selectedItemColor: AppColors.white,
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
            label: "My Club",
            icon: Icon(
              Icons.sports_soccer_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: "Person",
            icon: Icon(IconlyBold.profile),
          ),
        ],
      ),
    );
  }
}
