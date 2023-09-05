import 'package:flutter/material.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_appbar_tabar.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_one.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_three.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_two.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:provider/provider.dart';

class MyClubView extends StatefulWidget {
  const MyClubView({super.key});

  @override
  State<MyClubView> createState() => _MyClubViewState();
}

class _MyClubViewState extends State<MyClubView> {
  String? userClubId;

  @override
  void initState() {
    userClubId = context.read<UserViewModel>().userClubId;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getClubAndPlayers();
      getUserHostedTournaments();
      getUserRegisteredTournaments();
    });

    super.initState();
  }

  Future<void> getUserRegisteredTournaments() async {
    var userHostRegProvider = context.read<UserHostRegTournamentViewModel>();
    if (userClubId != null && userClubId!.isNotEmpty) {
      userHostRegProvider.apiResponseRegisTournaments.data ??
          await userHostRegProvider.getAllUserRegisteredTournaments();
    }
  }

  Future<void> getUserHostedTournaments() async {
    var userHostRegProvider = context.read<UserHostRegTournamentViewModel>();
    if (userClubId != null && userClubId!.isNotEmpty) {
      userHostRegProvider.apiResponseHostedTournaments.data ??
          await userHostRegProvider.getAllUserHostedTournaments();
    }
  }

  Future<void> getClubAndPlayers() async {
    var myClubViewModel = context.read<MyClubViewModel>();
    if (userClubId != null && userClubId!.isNotEmpty) {
      myClubViewModel.getClubApiResponse.data ??
          myClubViewModel.getMyClub(context);
      myClubViewModel.getPlayerapiResponse.data ??
          myClubViewModel.getAllPlayers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyClubViewModel>(
      builder: (context, myClubViewModel, _) {
        return DefaultTabController(
          initialIndex: myClubViewModel.currentIndex,
          length: 3,
          child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100.00),
              child: MyclubAppbarTabbar(),
            ),
            body: TabBarView(
              children: [
                MyClubTabOne(userClubId: userClubId),
                MyClubTabTwo(userClubId: userClubId),
                MyClubTabThree(userClubId: userClubId),
              ],
            ),
          ),
        );
      },
    );
  }
}
