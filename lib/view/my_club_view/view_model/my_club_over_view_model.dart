import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/view/my_club_view/model/club_tournamentmodel.dart';
import 'package:offpitch_app/view/my_club_view/model/players_model.dart';
import 'package:offpitch_app/view/my_club_view/repository/club_repository.dart';
import 'package:offpitch_app/view_model/auth_view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class MyClubViewModel extends ChangeNotifier {
  final _myRepo = ClubRepository();

  int count = 0;

  int currentIndex = 0;

  List<bool> selectedPlayers = [];

  ApiResponse<ClubTournamentModel> getClubApiResponse = ApiResponse.loading();

  ApiResponse<PlayersModel> getPlayerapiResponse = ApiResponse.loading();

  void setCurrenIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void setMyClubdetails(ApiResponse<ClubTournamentModel> response) {
    getClubApiResponse = response;
    notifyListeners();
  }

  Future<void> getMyClub(BuildContext context) async {
    setMyClubdetails(ApiResponse.loading());
    await _myRepo.getAllClubWithAccessTokem().then((value) async {
      setMyClubdetails(ApiResponse.completed(value));
      await context
          .read<UserViewModel>()
          .saveUserClubIdWhenClubcreate(value.data?.id, value.data?.status);
    }).onError((error, stackTrace) {
      setMyClubdetails(ApiResponse.error(error.toString()));
    });
  }

  void setAllPlayerslist(ApiResponse<PlayersModel> response) {
    getPlayerapiResponse = response;
    notifyListeners();
  }

  void setValueChecBoxIndex(PlayersModel players) {
    selectedPlayers = List.filled(players.data!.length, false);
  }

  Future<void> getAllPlayers() async {
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

  void clearAllDateLogout() {
    getClubApiResponse.status = null;
    getClubApiResponse.data = null;
    getPlayerapiResponse.status = null;
    getPlayerapiResponse.data = null;
  }
}
