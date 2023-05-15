import 'package:flutter/material.dart';
import 'package:offpitch_app/view_model/home_and_explore_view_model/explore_view_view_model.dart';
import 'package:provider/provider.dart';

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
  }
}
