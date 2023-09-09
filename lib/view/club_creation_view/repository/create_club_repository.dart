
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';
import '../model/create_new_club_model.dart';

class CreateClubRepository {
  BaseApiService apiService = NetworkApiServices();
  

  Future postClubapi(CreateClubModel data) async {
    try {
      final response = apiService.getPutApiWithAccessToken(
          AppUrl.clubCreation, createClubModelToJson(data));
      
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
