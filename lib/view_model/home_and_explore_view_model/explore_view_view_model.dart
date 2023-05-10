import 'dart:developer';
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

  setSearchTabbarIndex(int value) {
    searchTabbarCount = value;
    notifyListeners();
  }

  setliveTournaments(ApiResponse<List<AllTournament>> response) {
    liveTournaments = response;
    notifyListeners();
  }

  setallTournaments(ApiResponse<List<AllTournament>> response) {
    allTournaments = response;
    notifyListeners();
  }

  Future<void> getExpAndSrchTournmts(
      {required String query, required String sortingQuery}) async {
    // // set all tournaments for home=========

    setliveTournaments(ApiResponse.loading());
    setallTournaments(ApiResponse.loading());

    _myrepo.exploreAndSearchTournaments(query: query).then((value) {
      DateFormat inputFormat = DateFormat('dd MMM yyyy');
      DateFormat outputFormat = DateFormat('d M yyyy');
      final now = DateTime.now();
      String dateStr = "${now.day} ${now.month} ${now.year}";

      List<AllTournament> liveTournament = [];
      liveTournament.clear();

      List<AllTournament> allTournament = [];
      allTournament.clear();

      for (AllTournament element in value.data.allTournaments) {
        String input = element.startDate;
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

        log("live $dateStr");
        log("live $outputDate");
        log("==============");
      }

      // setLive tournaments
      setliveTournaments(ApiResponse.completed(liveTournament));

      // setAll tournament
      setallTournaments(ApiResponse.completed(allTournament));
    }).onError((error, stackTrace) {
      log(error.toString());
      // set all tournaments for home================
      setliveTournaments(ApiResponse.error(error.toString()));
      setallTournaments(ApiResponse.error(error.toString()));
    });
  }

  ExploreViewViewModel() {
    log("kkk");
    getExpAndSrchTournmts(query: 'filter=all', sortingQuery: "all");
  }
}
