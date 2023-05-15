import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/registered_teams.dart';
import 'package:offpitch_app/models/single_tournament_model.dart';
import 'package:offpitch_app/repository/registered_teams_repository.dart';
import 'package:offpitch_app/repository/tournament_details_repository.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsTouramentViewModel with ChangeNotifier {
  final _myRepo = TournamentDetailsRepository();

  String? _myClubId;
  String? get myClubId => _myClubId;
  ApiResponse<SingleTournamentModel> detailsTournament = ApiResponse.loading();
  setDetilsTournament(ApiResponse<SingleTournamentModel> allTournamest) {
    detailsTournament = allTournamest;
    notifyListeners();
  }

//  touranemt deatils api call==========
  Future getSingleTournament(id) async {
    setDetilsTournament(ApiResponse.loading());
    _myRepo.sigleTournamentDetails(id).then((value) {
      setDetilsTournament(ApiResponse.completed(value));
      log(value.toString());
      getMyClubId();
    }).onError((error, stackTrace) {
      setDetilsTournament(ApiResponse.error(error.toString()));
      log(error.toString());
    });
  }

  Duration? _remainingTime = Duration.zero;

  void calculateRemainingTime(
    String lastDate,
  ) {
    DateTime tournamentStartingDate = DateFormat("MM/dd/yyyy").parse(lastDate);
    DateTime futureDate = tournamentStartingDate.add(const Duration(days: 1));
    log(futureDate.toString());
    _remainingTime = futureDate.difference(DateTime.now());
    if (_remainingTime!.isNegative) {
      _remainingTime = Duration.zero;
      return;
    }

    Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingTime = tournamentStartingDate.difference(DateTime.now());

      if (_remainingTime!.isNegative) {
        _remainingTime = Duration.zero;
        timer.cancel();
      }

      notifyListeners();
    });
  }

  Duration? get remainingTime => _remainingTime!;

  Future getMyClubId() async {
    final sp = await SharedPreferences.getInstance();
    final myClubId = sp.getString('myClubId');
    AppUserIdAndTokens.userClubId = myClubId;
    log("j${AppUserIdAndTokens.userClubId.toString()}");
    _myClubId = myClubId;
  }

  bool registeredOrNotChecking(SingleTournamentModel? data) {
    bool conatain = false;
    for (var element in data!.data!.teams!) {
      if (element.club?.trim() == _myClubId?.trim()) {
        conatain = true;
      } else {
        conatain = false;
      }
    }
    return conatain;
  }

  bool registeredPendingStatusCheking(SingleTournamentModel? data) {
    bool conatain = false;
    for (var element in data!.data!.teams!) {
      if (element.club?.trim() == _myClubId?.trim()) {
        if (element.status == "pending") {
          conatain = true;
        }
      } else {
        conatain = false;
      }
    }
    return conatain;
  }

  bool userSheduleChecking(SingleTournamentModel? data) {
    bool conatain = false;
    if (data?.data?.host?.id == _myClubId) {
      conatain = true;
    }
    return conatain;
  }

  // registered Api call==================

  final _myReop2 = RegisteredTeamsRepository();

  ApiResponse<RegisterdTeamsModel> registeredTeams = ApiResponse.loading();

  setRegisterdTeams(ApiResponse<RegisterdTeamsModel> model) {
    registeredTeams = model;
    notifyListeners();
  }

  getRegisterdClubdetails(String? tId, cId) {
    setRegisterdTeams(ApiResponse.loading());
    _myReop2.getAllRegisteredClubs(tId, cId).then((value) {
      log(value.toString());
      setRegisterdTeams(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      log(error.toString());
      setRegisterdTeams(ApiResponse.error(error.toString()));
    });
  }

  DetailsTouramentViewModel() {
    getMyClubId();
  }

  clearAlldataLogout() {
    registeredTeams.data = null;
    detailsTournament.data = null;
    _myClubId = null;
  }
}
