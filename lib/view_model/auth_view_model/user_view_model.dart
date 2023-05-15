import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:offpitch_app/view_model/logout_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  String? _userClubId;
  String? get userClubId => _userClubId;

//  Save user accessToken in login api inside then call back method
  Future<bool> saveAcesssToken(UserModel userModel) async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('accessToken');
    sp.setString(
      'accessToken',
      userModel.data!.accessToken!,
    );
    notifyListeners();
    return true;
  }

//  Save user club id in login api inside then call back method
  Future saveUserClubId(UserModel model) async {
    final sp = await SharedPreferences.getInstance();
    if (model.data?.club != null &&
        model.data?.clubStatus != null &&
        model.data!.club!.isNotEmpty &&
        model.data!.clubStatus!.isNotEmpty) {
      log("account has club");
      sp.remove("userClub_id");
      sp.setString("userClub_id", model.data!.club!);
    }
    getUserClubId();
  }

  // get User Club id==================
  getUserClubId() async {
    final sp = await SharedPreferences.getInstance();
    _userClubId = sp.getString("userClub_id");
  }

  // Get user authToken Setted in NetWorkapi Service ==============
  Future<String?> getUser() async {
    final sp = await SharedPreferences.getInstance();
    final String? authToken = sp.getString("authToken");
    log(authToken.toString());
    notifyListeners();
    return authToken;
  }

  // logout remeve all data==========
  Future<bool> logoutRemoveAllData(BuildContext context) async {
    Provider.of<LogoutViewModel>(context, listen: false)
        .clearAllDatasLogout(context);
    final sp = await SharedPreferences.getInstance();
    await sp.remove('authToken');
    await sp.remove("userClub_id");
    await sp.remove("accessToken");
    return true;
  }
}
