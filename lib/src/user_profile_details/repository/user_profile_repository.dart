import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/src/user_profile_details/model/user_profile_model.dart';
import 'package:offpitch_app/src/user_watch_list/model/user_watchlist_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class UserProfileRepository {
  BaseApiService apiServices = NetworkApiServices();

  Future<UserProfileModel> getUserProfile() async {
    try {
      final resposne =
          await apiServices.getGetApiWithAccessToken(AppUrl.userProfile);
      return userProfileModelFromJson(resposne);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserWatchlistModel> getUserWatchList() async {
    try {
      final resposne =
          await apiServices.getGetApiWithAccessToken(AppUrl.userWatchlist);
      return userWatchlistModelFromJson(resposne);
    } catch (e) {
      rethrow;
    }
  }
}
