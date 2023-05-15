import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/club_tournamentmodel.dart';
import 'package:offpitch_app/models/players_model.dart';
import 'package:offpitch_app/repository/club_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyClubViewModel extends ChangeNotifier {
  final _myRepo = ClubRepository();
  int count = 0;

  bool isUserhasClub = false;

  // for registration view ============
  List<bool> selectedPlayers = [];

// get All club=====================
  ApiResponse<ClubTournamentModel> apiResponse = ApiResponse.loading();

  setMyClubdetails(ApiResponse<ClubTournamentModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future getMyClub() async {
    setMyClubdetails(ApiResponse.loading());
    _myRepo.getAllClubWithAccessTokem().then((value) async {
      isUserhasClub = value.success;
      // stored my club id in local storage===============
      isUserhasClub = value.success;
      final sp = await SharedPreferences.getInstance();
      if (value.data?.id != null) {
        final String myClubId = value.data!.id!;
        sp.setString('myClubId', myClubId);
      }
      setMyClubdetails(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMyClubdetails(ApiResponse.error(error.toString()));
    });
  }

// get all players====================
  ApiResponse<PlayersModel> getPlayerapiResponse = ApiResponse.loading();

  setAllPlayerslist(ApiResponse<PlayersModel> response) {
    getPlayerapiResponse = response;
    notifyListeners();
  }

  setValueChecBoxIndex(PlayersModel players) {
    selectedPlayers = List.filled(players.data!.length, false);
  }

  Future getAllPlayers() async {
    setAllPlayerslist(ApiResponse.loading());
    await _myRepo.getAllPlayerWithAccessToken().then(
      (value) {
        setValueChecBoxIndex(value);
        setAllPlayerslist(ApiResponse.completed(value));
        log("suscess");
      },
    ).onError(
      (error, stackTrace) {
        log(error.toString());
        setAllPlayerslist(ApiResponse.error(error.toString()));
      },
    );
  }

  clearAllDateLogout() {
    apiResponse.data = null;
    getPlayerapiResponse.data = null;
  }

  MyClubViewModel() {
    getMyClub();
    getAllPlayers();
  }
}
