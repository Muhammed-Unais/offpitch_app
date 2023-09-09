
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';

class SheduleTournametRespository {
  BaseApiService apiService = NetworkApiServices();

  Future getGetTournamentSchedule(id) async {
    try {
      final response = await apiService.getGetApiWithAccessToken(
          "${AppUrl.scheduleTournament}/$id/schedule");

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
