import 'package:flutter/material.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/explore_view_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:offpitch_app/view_model/my_club_view_model/myclub_user_hostreg_tour_view_model.dart';
import 'package:provider/provider.dart';

import 'user_profile_view_model/user_profile_view_model.dart';

class BottomBarViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  onTap(int index, context, {PageController? controller}) {
    _currentIndex = index;
    notifyListeners();

    if (index == 4) {
      final value = Provider.of<UserProfileViewModel>(context, listen: false);
      value.userProfileResponse.data ?? value.getUserProfile();
      value.userProfileWatchlist.data ?? value.getUserProfileWatchlist();
    }
  }
}
