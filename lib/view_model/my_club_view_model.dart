
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/club_tournamentmodel.dart';
import 'package:offpitch_app/repository/club_repository.dart';

class MyClubViewModel extends ChangeNotifier {
  final _myRepo = ClubRepository();

  ApiResponse<ClubTournamentModel> apiResponse = ApiResponse.loading();

  setMyClubdetails(ApiResponse<ClubTournamentModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future getMyClub() async {
    setMyClubdetails(ApiResponse.loading());
    _myRepo.getAllClubWithAccessTokem().then((value) {
      setMyClubdetails(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMyClubdetails(ApiResponse.error(error.toString()));
    });
  }
}
