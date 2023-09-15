import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:offpitch_app/features/explore_view/model/all_tournaments_model.dart';

class ExploreRepository {
  final BaseApiService _apiService = NetworkApiServices();

  Future<AllTournamentsModel> exploreAndSearchTournaments(
      {required String query}) async {
    try {
      dynamic response = await _apiService.getGetApiResponse(
          AppUrl.allTournaments, "?$query");
      return response = allTournamentsModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
