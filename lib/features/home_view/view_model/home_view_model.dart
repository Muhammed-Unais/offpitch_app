import 'package:flutter/foundation.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/features/explore_view/model/all_tournaments_model.dart';
import 'package:offpitch_app/features/home_view/repository/home_repository.dart';

enum HomeTournamentsEnum { all, live, upcoming }

class HomeViewModel extends ChangeNotifier {
  HomeTournamentsEnum homeTournamentsChip = HomeTournamentsEnum.all;
  
  final _myrepo = HomeRepository();

  int _count = 0;

  int get count => _count;

  late String selcetedChip;

  ApiResponse<AllTournamentsModel>? apiResponse = ApiResponse.loading();

  void setSelectingChip(String chipName) {
    if (chipName == "All") homeTournamentsChip = HomeTournamentsEnum.all;
    if (chipName == "Live") homeTournamentsChip = HomeTournamentsEnum.live;
    if (chipName == "Upcoming") homeTournamentsChip = HomeTournamentsEnum.upcoming;
    selcetedChip = chipName;
    notifyListeners();
  }

  void setApiresponse(ApiResponse<AllTournamentsModel> apiResponses) {
    apiResponse = apiResponses;
    notifyListeners();
  }

  Future<void> getAllTournaments() async {
    setApiresponse(ApiResponse.loading());
    _myrepo.allTournamentApi().then((value) {
      if (value.data!.allTournaments!.length > 4) {
        _count = 4;
      } else {
        _count = value.data!.allTournaments!.length;
      }
      setApiresponse(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setApiresponse(ApiResponse.error(error.toString()));
    });
  }

  void clearAllDataLogout() {
    apiResponse?.data = null;
  }
}
