import 'package:flutter/foundation.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/repository/home_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final _myrepo = HomeRepository();

  int _count = 0;

  int get count => _count;

  ApiResponse<AllTournamentsModel>? apiResponse = ApiResponse.loading();

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
