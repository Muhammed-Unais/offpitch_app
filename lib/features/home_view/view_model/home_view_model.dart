import 'package:flutter/foundation.dart';

enum HomeTournamentsEnum { all, live, upcoming }

class HomeViewModel extends ChangeNotifier {
  HomeTournamentsEnum homeTournamentsChip = HomeTournamentsEnum.all;
  

  late String selcetedChip;

  void setSelectingChip(String chipName) {
    if (chipName == "All") homeTournamentsChip = HomeTournamentsEnum.all;
    if (chipName == "Live") homeTournamentsChip = HomeTournamentsEnum.live;
    if (chipName == "Upcoming") homeTournamentsChip = HomeTournamentsEnum.upcoming;
    selcetedChip = chipName;
    notifyListeners();
  }
}
