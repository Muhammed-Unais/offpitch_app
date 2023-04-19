import 'package:flutter/material.dart';
import 'package:offpitch_app/view_model/my_club_view_model.dart';
import 'package:provider/provider.dart';

class BottomBarViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  onTap(int index, context) {
    if (index == 3) {
      Provider.of<MyClubViewModel>(context,listen: false).getMyClub();
    }
    _currentIndex = index;
    notifyListeners();
  }
}
