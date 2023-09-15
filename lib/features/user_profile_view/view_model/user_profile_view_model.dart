import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/data/response/api_response.dart';
import 'package:offpitch_app/features/user_profile_view/model/user_profile_model.dart';
import 'package:offpitch_app/features/user_profile_view/repository/user_profile_repository.dart';
import 'package:offpitch_app/features/user_watch_list_view/model/user_watchlist_model.dart';

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
      (value) {
        log(value.data!.id.toString());

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
        log(value.toString());
      },
    ).onError(
      (error, stackTrace) {
        log(error.toString());
        setUserProfileWatchlist(ApiResponse.error(error.toString()));
      },
    );
  }

  UserProfileViewModel() {
    getUserProfile();
    getUserProfileWatchlist();
  }

  clearAlldataLogout() {
    userProfileResponse.data = null;
    userProfileWatchlist.data = null;
  }
}
