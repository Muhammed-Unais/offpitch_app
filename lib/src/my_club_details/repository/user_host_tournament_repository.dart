
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/src/my_club_details/model/user_host_tournament_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class UserHostTournamentRepository {
  BaseApiService apiService = NetworkApiServices();

  Future<UserHostTournametModel?> getAllUserHostTorunament() async {
    try {
      final response = await apiService
          .getGetApiWithAccessToken(AppUrl.userHostedTournaments);
      return userHostTournametModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
