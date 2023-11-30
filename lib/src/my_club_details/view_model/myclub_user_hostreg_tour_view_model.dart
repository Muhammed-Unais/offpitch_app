import 'package:flutter/foundation.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/src/my_club_details/model/user_host_tournament_model.dart';
import 'package:offpitch_app/src/my_club_details/model/user_registered_model.dart';
import 'package:offpitch_app/src/my_club_details/repository/user_host_tournament_repository.dart';
import '../repository/user_registerd_tournaments_repository.dart';

class UserHostRegTournamentViewModel extends ChangeNotifier {
  final _myRepo = UserHostTournamentRepository();

  ApiResponse<List<HostedTournaments>> apiResponseHostedTournaments = ApiResponse.loading();

  ApiResponse<List<RegisteredTournaments>> apiResponseRegisTournaments =
      ApiResponse.loading();

  void setAllUserTournaments(ApiResponse<List<HostedTournaments>> data) {
    apiResponseHostedTournaments = data;
    notifyListeners();
  }

  void setAllUserRegTournaments(ApiResponse<List<RegisteredTournaments>> data) {
    apiResponseRegisTournaments = data;
    notifyListeners();
  }

  Future<void> getAllUserHostedTournaments() async {
    setAllUserTournaments(ApiResponse.loading());

    await _myRepo.getAllUserHostTorunament().then((value) {
      List<HostedTournaments> allCompletedTour = [];
      allCompletedTour.clear();
      for (var element in value!.data!) {
        if (element.status != StatusTour.DRAFT) {
          allCompletedTour.add(element);
        }
      }
      setAllUserTournaments(ApiResponse.completed(allCompletedTour));
    }).onError((error, stackTrace) {
      setAllUserTournaments(ApiResponse.error(error.toString()));
    });
  }

  final _myRegsteredRepo = UserRegisteredTournamentsRepository();

  Future<void> getAllUserRegisteredTournaments() async {
    setAllUserRegTournaments(ApiResponse.loading());
    _myRegsteredRepo.getUserRegistedTournaments().then((value) {
      setAllUserRegTournaments(ApiResponse.completed(value.data));
    }).onError((error, stackTrace) {
      setAllUserRegTournaments(ApiResponse.error(error.toString()));
    });
  }

  void clearAllDataLogout() {
    apiResponseHostedTournaments.data = null;
    apiResponseRegisTournaments.data = null;
  }
}
