
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:offpitch_app/features/my_club_view/model/user_registered_model.dart';

class UserRegisteredTournamentsRepository {
  BaseApiService apiService = NetworkApiServices();

  Future<UserRegisterdTournametnModel> getUserRegistedTournaments() async {
    try {
      final response = await apiService
          .getGetApiWithAccessToken(AppUrl.userRegisteredTournamements);
      return userRegisterdTournametnModelFromJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
