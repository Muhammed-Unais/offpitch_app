import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:offpitch_app/features/my_club_view/model/club_tournamentmodel.dart';
import 'package:offpitch_app/features/my_club_view/model/players_model.dart';

class ClubRepository {
  BaseApiService apiService = NetworkApiServices();

  Future<ClubTournamentModel> getAllClubWithAccessTokem() async {
    try {
      dynamic response = await apiService.getGetApiWithAccessToken(AppUrl.club);
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
