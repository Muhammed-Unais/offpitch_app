import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/repository/tournament_details_repository.dart';

class DetailsTouramentViewModel with ChangeNotifier {
  final _myRepo = TournamentDetailsRepository();

  ApiResponse<SingleTournamentModel> detailsTournament = ApiResponse.loading();
  setDetilsTournament(ApiResponse<SingleTournamentModel> allTournamest) {
    detailsTournament = allTournamest;
    notifyListeners();
  }

  Future getSingleTournament(id) async {
    setDetilsTournament(ApiResponse.loading());
    _myRepo.sigleTournamentDetails(id).then((value) {
      setDetilsTournament(ApiResponse.completed(value));
      log(value.toString());
    }).onError((error, stackTrace) {
      setDetilsTournament(ApiResponse.error(error.toString()));
      log(error.toString());
    });
  }
}
