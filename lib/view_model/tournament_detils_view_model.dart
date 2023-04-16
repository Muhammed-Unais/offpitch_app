import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/repository/tournament_details_repository.dart';

class DetailsTouramentViewModel with ChangeNotifier {
  final _myRepo = TournamentDetailsRepository();

  ApiResponse<AllTournament> detailsTournament = ApiResponse.loading();
  setDetilsTournament(ApiResponse<AllTournament> allTournamest) {
    detailsTournament = allTournamest;
    notifyListeners();
  }

  Future getSingleTournament(id) async {
    _myRepo.sigleTournamentDetails(id).then((value) {
      log(value.toString());
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
