
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/src/tournament_details/model/single_tournament_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class TournamentDetailsRepository {
  final BaseApiService _apiService = NetworkApiServices();

  Future<SingleTournamentModel> sigleTournamentDetails(id) async {
    try {
      dynamic response =
          await _apiService.getGetApiResponse(AppUrl.singleTournament,id);
      return response =singleTournamentModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
