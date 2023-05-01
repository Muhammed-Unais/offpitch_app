import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/user_host_tournament_model.dart';
import 'package:offpitch_app/repository/user_host_tournament_repository.dart';

class UserHostedTournamentViewModel extends ChangeNotifier {
  final _myRepo = UserHostTournamentRepository();

  ApiResponse<List<Datum>> apiResponse = ApiResponse.loading();


  setAllUserTournaments(ApiResponse<List<Datum>> data) {
    apiResponse = data;
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

  UserHostedTournamentViewModel() {
    getAllUserHostedTournaments();
  }
}
