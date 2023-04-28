import 'dart:developer';
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/models/club_tournamentmodel.dart';
import 'package:offpitch_app/models/players_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class ClubRepository {
  BaseApiService apiService = NetworkApiServices();

  Future<ClubTournamentModel> getAllClubWithAccessTokem() async {
    try {
      dynamic response = await apiService.getGetApiWithAccessToken(AppUrl.club);
      log(response.toString());
      return response = clubTournamentModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<PlayersModel> getAllPlayerWithAccessToken() async {
    try {
      final response =await apiService.getGetApiWithAccessToken(AppUrl.playersClub);
      return playersModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
