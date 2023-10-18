import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/src/explore_view/model/all_tournaments_model.dart';
import 'package:offpitch_app/src/explore_view/repository/explore_repository.dart';

enum Exploretournaments { all, live, upcoming }

class ExploreViewViewModel extends ChangeNotifier {
  Exploretournaments _exploretournaments = Exploretournaments.all;

  Exploretournaments get exploretournaments => _exploretournaments;

  set setExploretournaments(Exploretournaments exploreIntial) {
    _exploretournaments = exploreIntial;
  }

  TextEditingController searchTextEditingController = TextEditingController();

  final _myrepo = ExploreRepository();

  int? searchTabbarCount = 0;

  ApiResponse<List<AllTournament>> liveTournaments = ApiResponse.loading();

  ApiResponse<List<AllTournament>> allTournaments = ApiResponse.loading();

  ApiResponse<List<AllTournament>> upcomingTournaments = ApiResponse.loading();

  void setSearchTabbarIndex(int value) {
    if (value == 0) {
      _exploretournaments = Exploretournaments.all;
    }
    if (value == 1) {
      _exploretournaments = Exploretournaments.live;
    }
    if (value == 2) {
      _exploretournaments = Exploretournaments.upcoming;
    }
    searchTabbarCount = value;
    notifyListeners();
  }

  void setliveTournaments(ApiResponse<List<AllTournament>> response) {
    liveTournaments = response;

    notifyListeners();
  }

  void setallTournaments(ApiResponse<List<AllTournament>> response) {
    allTournaments = response;

    notifyListeners();
  }

  void setUpcomingTournaments(ApiResponse<List<AllTournament>> response) {
    upcomingTournaments = response;

    notifyListeners();
  }

  Future<void> getExpAndSrchTournmts(
      {required String query, required String sortingQuery, required}) async {
    if (sortingQuery == "upcoming") {
      setUpcomingTournaments(ApiResponse.loading());
    }

    if (sortingQuery == "all") {
      setliveTournaments(ApiResponse.loading());
      setallTournaments(ApiResponse.loading());
    }

    _myrepo.exploreAndSearchTournaments(query: query).then((value) {
      DateFormat inputFormat = DateFormat('dd MMM yyyy');
      DateFormat outputFormat = DateFormat('d M yyyy');
      final now = DateTime.now();
      String dateStr = "${now.day} ${now.month} ${now.year}";

      late List<AllTournament> liveTournament;

      late List<AllTournament> allTournament;

      late List<AllTournament> upComingTournament;

      if (sortingQuery == "all") {
        allTournament = [];
        liveTournament = [];
        allTournament.clear();
        liveTournament.clear();
      }

      if (sortingQuery == "upcoming") {
        upComingTournament = [];
        upComingTournament.clear();
      }

      for (AllTournament element in value.data!.allTournaments!) {
        String input = element.startDate!;
        DateTime startDate = inputFormat.parse(input);
        String outputDate = outputFormat.format(startDate);
        DateTime forUpcomingDate = DateFormat('dd MMM yyyy').parse(input);

        if (forUpcomingDate.isAfter(now) && sortingQuery == "upcoming") {
          upComingTournament.add(element);
        }

        // LIVE=================
        if (dateStr.trim() == outputDate.trim() && sortingQuery == "all") {
          liveTournament.add(element);
        }

        // AllTOURNMENTS========
        if (sortingQuery == "all") {
          allTournament.add(element);
        }
      }

      if (sortingQuery == "upcoming") {
        setUpcomingTournaments(ApiResponse.completed(upComingTournament));
      }

      // setAll tournament
      if (sortingQuery == "all") {
        setallTournaments(ApiResponse.completed(allTournament));
        setliveTournaments(ApiResponse.completed(liveTournament));
      }
    }).onError((error, stackTrace) {
      // set all tournaments for home================
      setliveTournaments(ApiResponse.error(error.toString()));
      setallTournaments(ApiResponse.error(error.toString()));
      setUpcomingTournaments(ApiResponse.error(error.toString()));
    });
  }

  void clearAllDataLogout() {
    allTournaments.status = Status.LOADING;
    liveTournaments.data = null;
    upcomingTournaments.data = null;
    allTournaments.data = null;
  }
}
