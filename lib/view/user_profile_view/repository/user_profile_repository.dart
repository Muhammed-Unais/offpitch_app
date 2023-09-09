import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/view/user_profile_view/model/user_profile_model.dart';
import 'package:offpitch_app/view/user_watch_list_view/model/user_watchlist_model.dart';
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
