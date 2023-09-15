import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';
import '../../explore_view/model/all_tournaments_model.dart';

class HomeRepository {
  final BaseApiService _apiService = NetworkApiServices();

  Future<AllTournamentsModel> allTournamentApi() async {
    try {
      dynamic response =
          await _apiService.getGetApiResponse("${AppUrl.allTournaments}?limit=45","");
      return response = allTournamentsModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
