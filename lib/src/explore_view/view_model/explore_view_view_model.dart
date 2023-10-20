import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/data/response/status.dart';
import 'package:offpitch_app/src/explore_view/model/all_tournaments_model.dart';
import 'package:offpitch_app/src/explore_view/repository/explore_repository.dart';

class ExploreViewViewModel extends ChangeNotifier {

  final _myrepo = ExploreRepository();

  int? searchTabbarCount = 0;

  ApiResponse<List<AllTournament>> liveTournaments = ApiResponse.loading();

  ApiResponse<List<AllTournament>> allTournaments = ApiResponse.loading();

  ApiResponse<List<AllTournament>> upcomingTournaments = ApiResponse.loading();

  int _allTournamentCount = 0;

  int get allTournamentCount => _allTournamentCount;

 
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

  Future<void> getAllandLiveTournaments({String query = ""}) async {
    
    String queries = "filter=all&$query&limit=10";
    setliveTournaments(ApiResponse.loading());
    setallTournaments(ApiResponse.loading());

    _myrepo.exploreAndSearchTournaments(query: queries).then((value) {
      DateFormat inputFormat = DateFormat('dd MMM yyyy');
      DateFormat outputFormat = DateFormat('d M yyyy');
      final now = DateTime.now();
      String dateStr = "${now.day} ${now.month} ${now.year}";

      late List<AllTournament> liveTournament;

      late List<AllTournament> allTournament;

      allTournament = [];
      liveTournament = [];
      allTournament.clear();
      liveTournament.clear();

      for (AllTournament tournaments in value.data!.allTournaments!) {
        String input = tournaments.startDate!;
        DateTime startDate = inputFormat.parse(input);
        String outputDate = outputFormat.format(startDate);

        // LIVE=================
        if (dateStr.trim() == outputDate.trim()) {
          liveTournament.add(tournaments);
        }

        allTournament.add(tournaments);
      }
      _allTournamentCount = value.data!.total!;
      setallTournaments(ApiResponse.completed(allTournament));
      setliveTournaments(ApiResponse.completed(liveTournament));
    }).onError((error, stackTrace) {
      setliveTournaments(ApiResponse.error(error.toString()));
      setallTournaments(ApiResponse.error(error.toString()));
    });
  }

  Future<List<AllTournament>> paginationAllandLiveTournaments(
      {String query = ""}) async {
    List<AllTournament> allTournamentValus = [];
    String queries = "filter=all&$query&limit=10";

    await _myrepo.exploreAndSearchTournaments(query: queries).then((value) {
      DateFormat inputFormat = DateFormat('dd MMM yyyy');
      DateFormat outputFormat = DateFormat('d M yyyy');
      final now = DateTime.now();
      String dateStr = "${now.day} ${now.month} ${now.year}";

      List<AllTournament> liveTournament = [];

      List<AllTournament> allTournament = [];

      List<AllTournament> upComingTournament = [];

      allTournament.clear();
      liveTournament.clear();

      for (AllTournament tournaments in value.data!.allTournaments!) {
        String input = tournaments.startDate!;
        DateTime startDate = inputFormat.parse(input);
        String outputDate = outputFormat.format(startDate);
        DateTime forUpcomingDate = DateFormat('dd MMM yyyy').parse(input);

        // LIVE=================
        if (dateStr.trim() == outputDate.trim()) {
          liveTournament.add(tournaments);
        }

        if (forUpcomingDate.isAfter(now)) {
          upComingTournament.add(tournaments);
        }

        allTournament.add(tournaments);
      }
      setliveTournaments(ApiResponse.completed(liveTournament));
      setUpcomingTournaments(ApiResponse.completed(upComingTournament));
      allTournamentValus = allTournament;
    });

    return allTournamentValus;
  }

  Future<void> getUpComingTournaments({String query = ''}) async {
    String queries = "filter=all";
    setUpcomingTournaments(ApiResponse.loading());

    _myrepo.exploreAndSearchTournaments(query: queries).then((value) {
      final now = DateTime.now();

      late List<AllTournament> upComingTournament;

      upComingTournament = [];
      upComingTournament.clear();

      for (AllTournament tournaments in value.data!.allTournaments!) {
        String input = tournaments.startDate!;

        DateTime forUpcomingDate = DateFormat('dd MMM yyyy').parse(input);

        if (forUpcomingDate.isAfter(now)) {
          upComingTournament.add(tournaments);
        }
      }
      setUpcomingTournaments(ApiResponse.completed(upComingTournament));
    }).onError((error, stackTrace) {
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
