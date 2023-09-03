import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/repository/explore_repository.dart';

class ExploreViewViewModel extends ChangeNotifier {
  final _myrepo = ExploreRepository();

  int? searchTabbarCount = 0;

  ApiResponse<List<AllTournament>> liveTournaments = ApiResponse.loading();

  ApiResponse<List<AllTournament>> allTournaments = ApiResponse.loading();

  // ApiResponse<AllTournamentsModel> upcomingTournments = ApiResponse.loading();

  void setSearchTabbarIndex(int value) {
    searchTabbarCount = value;
    notifyListeners();
  }

  void setliveTournaments(ApiResponse<List<AllTournament>> response, bool isNotify) {
    liveTournaments = response;

    if (isNotify) {
      notifyListeners();
    }
  }

  void setallTournaments(ApiResponse<List<AllTournament>> response, bool isNotify) {
    allTournaments = response;

    if (isNotify) {
      notifyListeners();
    }
  }

  Future<void> getExpAndSrchTournmts(
      {required String query,
      required String sortingQuery,
      required bool isNotify}) async {
    // // set all tournaments for home=========

    setliveTournaments(ApiResponse.loading(), isNotify);
    setallTournaments(ApiResponse.loading(), isNotify);

    _myrepo.exploreAndSearchTournaments(query: query).then((value) {
      DateFormat inputFormat = DateFormat('dd MMM yyyy');
      DateFormat outputFormat = DateFormat('d M yyyy');
      final now = DateTime.now();
      String dateStr = "${now.day} ${now.month} ${now.year}";

      List<AllTournament> liveTournament = [];
      liveTournament.clear();

      List<AllTournament> allTournament = [];
      allTournament.clear();

      for (AllTournament element in value.data!.allTournaments!) {
        String input = element.startDate!;
        DateTime startDate = inputFormat.parse(input);
        String outputDate = outputFormat.format(startDate);
        DateTime forUpcomingDate = DateFormat('dd MMM yyyy').parse(input);

        // UPCOMING=============
        if (forUpcomingDate.isAfter(now) && sortingQuery == "upComing") {
          allTournament.add(element);
        }

        // LIVE=================
        if (dateStr.trim() == outputDate.trim()) {
          liveTournament.add(element);
        }

        // AllTOURNMENTS========
        if (sortingQuery == "all") {
          allTournament.add(element);
        }
      }

      // setLive tournaments
      setliveTournaments(ApiResponse.completed(liveTournament), isNotify);

      // setAll tournament
      setallTournaments(ApiResponse.completed(allTournament), isNotify);
    }).onError((error, stackTrace) {
      // set all tournaments for home================
      setliveTournaments(ApiResponse.error(error.toString()), isNotify);
      setallTournaments(ApiResponse.error(error.toString()), isNotify);
    });
  }

  clearAllDataLogout() {
    liveTournaments.data = null;
    allTournaments.data = null;
  }

  ExploreViewViewModel() {
    getExpAndSrchTournmts(
        query: 'filter=all', sortingQuery: "all", isNotify: true);
  }
}
