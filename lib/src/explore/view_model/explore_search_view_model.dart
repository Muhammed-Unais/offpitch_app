import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/src/explore/model/all_tournaments_model.dart';
import 'package:offpitch_app/src/explore/repository/explore_repository.dart';

class ExploreSearchViewModel with ChangeNotifier {

  final _myrepo = ExploreRepository();

  ApiResponse<List<AllTournament>> searchResultsTournament =
      ApiResponse.loading();

  void setSearchResults(ApiResponse<List<AllTournament>> response) {
    searchResultsTournament = response;
    notifyListeners();
  }

  Future<void> getSearchResultsTournaments({String query = ""}) async {
    String queries = "filter=all&$query&limit=25";
    setSearchResults(ApiResponse.loading());

    _myrepo.exploreAndSearchTournaments(query: queries).then((value) {
      

      setSearchResults(ApiResponse.completed(value.data!.allTournaments));
    }).onError((error, stackTrace) {
      setSearchResults(ApiResponse.error(error.toString()));
    });
  }
}
