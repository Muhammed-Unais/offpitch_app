import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/models/all_tournaments_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class HomeRepository {
  final BaseApiService _apiService = NetworkApiServices();

  Future<AllTournamentsModel> allTournamentApi() async {
    try {
      dynamic response =
          await _apiService.getGetApiResponse(AppUrl.allTournaments,"");
      return response = allTournamentsModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
