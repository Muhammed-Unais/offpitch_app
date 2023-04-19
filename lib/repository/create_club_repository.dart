import 'dart:developer';

import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/models/create_new_club_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class CreateClubRepository {
  BaseApiService apiService = NetworkApiServices();

  Future postClubapi(CreateClubModel data) async {
    try {
      final response = apiService.getPostApiWithAccessToken(
          AppUrl.clubCreation, createClubModelToJson(data));

      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
