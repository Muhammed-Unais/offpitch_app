import 'dart:developer';

import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/features/my_club_view/model/add_players_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class AddPlayerRepository {
  BaseApiService apiService = NetworkApiServices();

  Future postPlayers(AddPlayersModel data) async {
    try {
      final response = await apiService.getPostApiWithAccessToken(
          AppUrl.addPlayers, addPlayersModelToJson(data));
      return response;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
