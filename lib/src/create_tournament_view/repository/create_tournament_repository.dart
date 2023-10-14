import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:offpitch_app/src/create_tournament_view/model/create_tournament_model.dart';

class CreateTournamentRepository {
  BaseApiService apiService = NetworkApiServices();

  Future putTournamentapi(CreateTournament data) async {
    try {
      final response = apiService.getPutApiWithAccessToken(
          AppUrl.createTournament, createTournamentToJson(data));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
