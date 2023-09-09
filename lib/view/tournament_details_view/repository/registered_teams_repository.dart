import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:offpitch_app/view/tournament_details_view/model/registered_teams.dart';

class RegisteredTeamsRepository {
  BaseApiService apiService = NetworkApiServices();

  Future<RegisterdTeamsModel> getAllRegisteredClubs(tId, cId) async {
    try {
      final response =await apiService.getGetApiResponse(
          "${AppUrl.registeredTeams}/$tId/club/$cId", "");
      return registerdTeamsModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
