import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/repository/explore_repository.dart';

class ExploreViewViewModel extends ChangeNotifier {
  final _myrepo = ExploreRepository();

  ApiResponse<AllTournamentsModel> liveTournaments = ApiResponse.loading();

  ApiResponse<AllTournamentsModel> allTournaments = ApiResponse.loading();

  ApiResponse<AllTournamentsModel> upcomingTournments = ApiResponse.loading();

  setliveTournaments(ApiResponse<AllTournamentsModel> response) {
    liveTournaments = response;
    notifyListeners();
  }

  setallTournaments(ApiResponse<AllTournamentsModel> response) {
    allTournaments = response;

    notifyListeners();
  }

  Future<void> getExpAndSrchTournmts({required String query}) async {
    // // set all tournaments for home=========

    if (query == "filter=live") {
      setliveTournaments(ApiResponse.loading());
    } else {
      setallTournaments(ApiResponse.loading());
    }

    _myrepo.exploreAndSearchTournaments(query: query).then((value) {
      // // set all tournaments for home=========
      if (query == "filter=live") {
        setliveTournaments(ApiResponse.completed(value));
      } else {
        setallTournaments(ApiResponse.completed(value));
      }
    }).onError((error, stackTrace) {
      log(error.toString());
      // set all tournaments for home================
      if (query == "filter=live") {
        setliveTournaments(ApiResponse.error(error.toString()));
      } else {
        setallTournaments(ApiResponse.error(error.toString()));
      }
    });
  }

  ExploreViewViewModel() {
    getExpAndSrchTournmts(query: 'filter=live');
    getExpAndSrchTournmts(query: 'filter=all');
  }
}
