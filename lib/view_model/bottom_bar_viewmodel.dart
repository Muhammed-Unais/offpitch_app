import 'package:flutter/material.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/explore_view_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_user_hostreg_tournament_view_model.dart';
import 'package:provider/provider.dart';

import 'user_profile_view_model/user_profile_view_model.dart';

class BottomBarViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  onTap(int index, context, {PageController? controller}) {
    _currentIndex = index;
    notifyListeners();
    if (index == 1) {
      final value = Provider.of<ExploreViewViewModel>(context, listen: false);
      value.allTournaments.data ??
          value.getExpAndSrchTournmts(query: 'filter=all', sortingQuery: "all");
    }
    if (index == 3) {
      final value = Provider.of<MyClubViewModel>(context, listen: false);

      value.apiResponse.data ?? value.getMyClub();
      value.getPlayerapiResponse.data ?? value.getAllPlayers();

      final value1 =
          Provider.of<UserHostRegTournamentViewModel>(context, listen: false);
      value1.apiResponse.data ?? value1.getAllUserHostedTournaments();

      final value2 =
          Provider.of<UserHostRegTournamentViewModel>(context, listen: false);
      value2.apiResponsetwo.data ?? value2.getAllUserRegisteredTournaments();
    }
    if (index == 4) {
      final value = Provider.of<UserProfileViewModel>(context, listen: false);
      value.userProfileResponse.data ?? value.getUserProfile();
      value.userProfileWatchlist.data ?? value.getUserProfileWatchlist();
    }
  }
}
