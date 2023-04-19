import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/repository/home_repository.dart';

class HomeAndExpViewModel extends ChangeNotifier {
  final _myrepo = HomeRepository();

  ApiResponse<AllTournamentsModel> allTournamentModel = ApiResponse.loading();

  ApiResponse<List<AllTournament>> upcomingTournament = ApiResponse.loading();

  ApiResponse<List<AllTournament>> todayTournaments = ApiResponse.loading();

  final List<AllTournament> _todayTournamentslist = [];

  final List<AllTournament> upcomingTournamentslist = [];

  setUpcomingTouranments(ApiResponse<List<AllTournament>> response) {
    upcomingTournament = response;
    notifyListeners();
  }

  setTodayTournaments(ApiResponse<List<AllTournament>> response) {
    todayTournaments = response;
    notifyListeners();
  }

  setTournaments(ApiResponse<AllTournamentsModel> response) {
    allTournamentModel = response;
    // notifyListeners();
  }

  Future<void> getAllTournaments() async {
    // // set all tournaments for home=========
    setTournaments(ApiResponse.loading());

    // set Upcoming touranments for explore page=====
    setUpcomingTouranments(ApiResponse.loading());

    // set today for explore page=====
    setTodayTournaments(ApiResponse.loading());

    _myrepo.allTournamentApi().then((value) {
      List<AllTournament> alltournament = value.data.allTournaments;

      // date formating=======
      DateFormat inputFormat = DateFormat('dd MMM yyyy');
      DateFormat outputFormat = DateFormat('dd M yyyy');
      DateTime today = DateTime.now();
      String dateStr = "${today.day} ${today.month} ${today.year}";
      log(dateStr);

      for (AllTournament element in alltournament) {
        String input = element.startDate;
        DateTime dateTime = inputFormat.parse(input);
        log(dateTime.toString());
        String outputDate = outputFormat.format(dateTime);
        log(outputDate.toString());
        if (dateStr.trim() != outputDate.trim()) {
          upcomingTournamentslist.add(element);
        } else {
          _todayTournamentslist.add(element);
        }
      }

      log(upcomingTournamentslist.toString());
      // log(_todayTournaments.length.toString());

      // // set all tournaments for home=========
      setTournaments(ApiResponse.completed(value));

      // set Upcoming touranments for explore page=====
      setUpcomingTouranments(ApiResponse.completed(upcomingTournamentslist));

      // // set all tournaments for home=========
      setTodayTournaments(ApiResponse.completed(_todayTournamentslist));
    }).onError((error, stackTrace) {
      // set all tournaments for home================
      setTournaments(ApiResponse.error(error.toString()));

      // set Upcoming touranments for explore page=========
      setUpcomingTouranments(ApiResponse.error(error.toString()));

      // set Today touranments for explore page=========
      setTodayTournaments(ApiResponse.error(error.toString()));
      log(error.toString());
    });
  }
}
