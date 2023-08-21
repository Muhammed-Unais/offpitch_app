import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/club_tournamentmodel.dart';
import 'package:offpitch_app/models/players_model.dart';
import 'package:offpitch_app/repository/club_repository.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class MyClubViewModel extends ChangeNotifier {
  final _myRepo = ClubRepository();
  int count = 0;

  // for registration view ============
  List<bool> selectedPlayers = [];

// get All club=====================
  ApiResponse<ClubTournamentModel> apiResponse = ApiResponse.loading();

  setMyClubdetails(ApiResponse<ClubTournamentModel> response) {
    apiResponse = response;
    notifyListeners();
  }

  Future getMyClub(BuildContext context) async {
    setMyClubdetails(ApiResponse.loading());
    await _myRepo.getAllClubWithAccessTokem().then((value) async {
      setMyClubdetails(ApiResponse.completed(value));
      context
          .read<UserViewModel>()
          .saveUserClubIdWhenClubcreate(value.data?.id,value.data?.status);
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
      },
    ).onError(
      (error, stackTrace) {
        setAllPlayerslist(ApiResponse.error(error.toString()));
      },
    );
  }

  clearAllDateLogout() {
    apiResponse.data = null;
    getPlayerapiResponse.data = null;
  }
}
