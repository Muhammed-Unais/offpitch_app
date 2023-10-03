import 'package:flutter/material.dart';
import 'package:offpitch_app/features/explore_view/view_model/explore_view_view_model.dart';
import 'package:offpitch_app/features/my_club_view/view_model/my_club_over_view_model.dart';
import 'package:provider/provider.dart';

import '../../user_profile_view/view_model/user_profile_view_model.dart';

class BottomBarViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  onTap(int index, BuildContext context, {PageController? controller}) {
    if (index == 0 || index == 1) {
      var exploreAndSearchProvider = context.read<ExploreViewViewModel>();
      exploreAndSearchProvider.searchTextEditingController.clear();
    }

    _currentIndex = index;
    notifyListeners();

    if (index == 3) {
      context.read<MyClubViewModel>().setCurrenIndex(0);
    }

    if (index == 3) {
      final value = Provider.of<UserProfileViewModel>(context, listen: false);
      value.userProfileResponse.data ?? value.getUserProfile();
      value.userProfileWatchlist.data ?? value.getUserProfileWatchlist();
    }
  }
}
