import 'dart:developer';
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';

class ClubRepository {
  BaseApiService apiService = NetworkApiServices();

  Future getAllClubWithAccessTokem() async {
    try {
      final response = await apiService.getGetApiWithAccessToken(AppUrl.club);
      log(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
