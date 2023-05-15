import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/user_host_tournament_model.dart';
import 'package:offpitch_app/models/user_registered_model.dart';
import 'package:offpitch_app/repository/user_host_tournament_repository.dart';
import 'package:offpitch_app/repository/user_registerd_tournaments_repository.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class UserHostRegTournamentViewModel extends ChangeNotifier {
  final _myRepo = UserHostTournamentRepository();

  ApiResponse<List<Datum>> apiResponse = ApiResponse.loading();

  ApiResponse<List<RegisteredTournaments>> apiResponsetwo =
      ApiResponse.loading();

  setAllUserTournaments(ApiResponse<List<Datum>> data) {
    apiResponse = data;
    notifyListeners();
  }

  setAllUserRegTournaments(ApiResponse<List<RegisteredTournaments>> data) {
    apiResponsetwo = data;
    notifyListeners();
  }

  getAllUserHostedTournaments() async {
    setAllUserTournaments(ApiResponse.loading());

    await _myRepo.getAllUserHostTorunament().then((value) {
      List<Datum> allCompletedTour = [];
      allCompletedTour.clear();
      for (var element in value!.data!) {
        if (element.status != StatusTour.DRAFT) {
          allCompletedTour.add(element);
          setAllUserTournaments(
            ApiResponse.completed(
              allCompletedTour,
            ),
          );
        }
      }
      log(value.toString());
    }).onError((error, stackTrace) {
      setAllUserTournaments(ApiResponse.error(error.toString()));

      log(error.toString());
    });
  }

  final _myRegsteredRepo = UserRegisteredTournamentsRepository();

  getAllUserRegisteredTournaments() async {
    setAllUserRegTournaments(ApiResponse.loading());
    _myRegsteredRepo.getUserRegistedTournaments().then((value) {
      setAllUserRegTournaments(ApiResponse.completed(value.data));
      log(value.data.toString());
    }).onError((error, stackTrace) {
      setAllUserRegTournaments(ApiResponse.error(error.toString()));
      log(error.toString());
    });
  }

  UserHostRegTournamentViewModel(context) {
    final userClubId =
        Provider.of<UserViewModel>(context, listen: false).userClubId;
    if (userClubId != null && userClubId.isNotEmpty) {
      getAllUserHostedTournaments();
      getAllUserRegisteredTournaments();
    }
  }

  clearAllDataLogout() {
    apiResponse.data = null;
    apiResponsetwo.data = null;
  }
}
