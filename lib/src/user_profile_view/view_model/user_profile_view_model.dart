import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/src/user_profile_view/model/user_profile_model.dart';
import 'package:offpitch_app/src/user_profile_view/repository/user_profile_repository.dart';
import 'package:offpitch_app/src/user_watch_list_view/model/user_watchlist_model.dart';
import 'package:offpitch_app/utils/utils.dart';

class UserProfileViewModel with ChangeNotifier {
  final _myRepo = UserProfileRepository();

  ApiResponse<UserProfileModel> userProfileResponse = ApiResponse.loading();
  ApiResponse<UserWatchlistModel> userProfileWatchlist = ApiResponse.loading();

//set User Profile===========
  setUserProfile(ApiResponse<UserProfileModel> response) {
    userProfileResponse = response;
    notifyListeners();
  }

//set User Watclist===========
  setUserProfileWatchlist(ApiResponse<UserWatchlistModel> response) {
    userProfileWatchlist = response;
    notifyListeners();
  }

//Get User Profile===========
  Future getUserProfile() async {
    setUserProfile(ApiResponse.loading());
    _myRepo.getUserProfile().then(
      (value) async {
        await Utils.sharedPrefrence(
            key: "userClubId", value: value.data?.id ?? "");

        setUserProfile(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setUserProfile(ApiResponse.error(error.toString()));
      },
    );
  }

//Get User Watclist===========
  Future getUserProfileWatchlist() async {
    setUserProfileWatchlist(ApiResponse.loading());
    _myRepo.getUserWatchList().then(
      (value) {
        setUserProfileWatchlist(ApiResponse.completed(value));
      },
    ).onError(
      (error, stackTrace) {
        setUserProfileWatchlist(ApiResponse.error(error.toString()));
      },
    );
  }

  UserProfileViewModel() {
    getUserProfile();
    getUserProfileWatchlist();
  }

  void clearAlldataLogout() {
    userProfileResponse.data = null;
    userProfileWatchlist.data = null;
  }
}
