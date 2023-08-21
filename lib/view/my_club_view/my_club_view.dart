import 'package:flutter/material.dart';
import 'package:offpitch_app/main.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_appbar_tabar.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_one.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_three.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_two.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:provider/provider.dart';

class MyClubView extends StatefulWidget {
  const MyClubView({super.key});

  @override
  State<MyClubView> createState() => _MyClubViewState();
}

class _MyClubViewState extends State<MyClubView> {
  UserViewModel userViewModel = UserViewModel();
  UserHostRegTournamentViewModel userHostRegTournamentViewModel =
      UserHostRegTournamentViewModel();
  String? userClubId;

  @override
  void initState() {
    userClubId = context.read<UserViewModel>().userClubId;
    getClubAndPlayers();
    getUserHostedTournaments();
    getUserRegisteredTournaments();
    super.initState();
  }

  void getUserRegisteredTournaments() async {
    if (userClubId != null && userClubId!.isNotEmpty) {
      userHostRegTournamentViewModel.apiResponseRegisTournaments.data ??
          await userHostRegTournamentViewModel
              .getAllUserRegisteredTournaments();
    }
  }

  void getUserHostedTournaments() async {
    if (userClubId != null && userClubId!.isNotEmpty) {
      userHostRegTournamentViewModel.apiResponseHostedTournaments.data ??
          await userHostRegTournamentViewModel.getAllUserHostedTournaments();
    }
  }

  void getClubAndPlayers() async {
    if (userClubId != null && userClubId!.isNotEmpty) {
      myClubViewModel.apiResponse.data ?? myClubViewModel.getMyClub(context);
      myClubViewModel.getPlayerapiResponse.data ??
          myClubViewModel.getAllPlayers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(120.00),
          child: MyclubAppbarTabbar(),
        ),
        body: ChangeNotifierProvider<UserHostRegTournamentViewModel>(
          create: (context) => userHostRegTournamentViewModel,
          child: TabBarView(
            children: [
              MyClubTabOne(userClubId: userClubId),
              MyClubTabTwo(userClubId: userClubId),
              MyClubTabThree(userClubId: userClubId),
            ],
          ),
        ),
      ),
    );
  }
}
