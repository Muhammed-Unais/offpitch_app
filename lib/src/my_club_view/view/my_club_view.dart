import 'package:flutter/material.dart';
import 'package:offpitch_app/src/my_club_view/components/my_club_appbar_tabar.dart';
import 'package:offpitch_app/src/my_club_view/components/my_club_tab_one.dart';
import 'package:offpitch_app/src/my_club_view/components/my_club_tab_three.dart';
import 'package:offpitch_app/src/my_club_view/components/my_club_tab_two.dart';
import 'package:offpitch_app/src/splash_screen/view_model/user_view_model.dart';
import 'package:offpitch_app/src/my_club_view/view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/src/my_club_view/view_model/myclub_user_hostreg_tour_view_model.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      userClubId = await context.read<UserViewModel>().getUserClubId();
      await getClubAndPlayers();
      await getUserHostedTournaments();
      await getUserRegisteredTournaments();
    });

    super.initState();
  }

  Future<void> getUserRegisteredTournaments() async {
    var userHostRegProvider = context.read<UserHostRegTournamentViewModel>();
    if (mounted && userClubId != null && userClubId!.isNotEmpty) {
      userHostRegProvider.apiResponseRegisTournaments.data ??
          await userHostRegProvider.getAllUserRegisteredTournaments();
    }
  }

  Future<void> getUserHostedTournaments() async {
    var userHostRegProvider = context.read<UserHostRegTournamentViewModel>();
    if (mounted && userClubId != null && userClubId!.isNotEmpty) {
      userHostRegProvider.apiResponseHostedTournaments.data ??
          await userHostRegProvider.getAllUserHostedTournaments();
    }
  }

  Future<void> getClubAndPlayers() async {
    var myClubViewModel = context.read<MyClubViewModel>();
    if (mounted && userClubId != null && userClubId!.isNotEmpty) {
      myClubViewModel.getClubApiResponse.data ??
          myClubViewModel.getMyClub(context);
      myClubViewModel.getPlayerapiResponse.data ??
          myClubViewModel.getAllPlayers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<MyClubViewModel, UserViewModel>(
      builder: (context, myClubViewModel, userViewModel, _) {
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
                MyClubTabOne(userClubId: userViewModel.userClubId),
                MyClubTabTwo(userClubId: userViewModel.userClubId),
                MyClubTabThree(userClubId: userViewModel.userClubId),
              ],
            ),
          ),
        );
      },
    );
  }
}
