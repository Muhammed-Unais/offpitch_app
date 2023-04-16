import 'dart:developer';

import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';

class TournamentDetailsRepository {
  final BaseApiService _apiService = NetworkApiServices();

  Future sigleTournamentDetails(id) async {
    try {
      final response =
          await _apiService.getGetApiResponse(AppUrl.singleTournament,id);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
