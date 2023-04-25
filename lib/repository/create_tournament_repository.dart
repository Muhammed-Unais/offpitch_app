import 'dart:developer';

import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/models/create_tournament_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class CreateTournamentRepository {
  BaseApiService apiService = NetworkApiServices();

  Future putTournamentapi(CreateTournament data) async {
    try {
      final response = apiService.getPutApiWithAccessToken(
          AppUrl.createTournament, createTournamentToJson(data));
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}