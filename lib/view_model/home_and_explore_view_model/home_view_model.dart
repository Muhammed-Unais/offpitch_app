import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/repository/home_repository.dart';

class HomeAndExpViewModel extends ChangeNotifier {
  final _myrepo = HomeRepository();

  ApiResponse<AllTournamentsModel> allTournamentModel = ApiResponse.loading();

  setTournaments(ApiResponse<AllTournamentsModel> response) {
    allTournamentModel = response;
    notifyListeners();
  }

  Future<void> getAllTournaments() async {
    // // set all tournaments for home=========
    setTournaments(ApiResponse.loading());

    _myrepo.allTournamentApi().then((value) {
      // // set all tournaments for home=========
      setTournaments(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      log(error.toString());
      // set all tournaments for home================
      setTournaments(ApiResponse.error(error.toString()));
    });
  }

  HomeAndExpViewModel() {
    getAllTournaments();
  }
}