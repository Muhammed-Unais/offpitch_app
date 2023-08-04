import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view_model/logout_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  String? _userClubId;
  String? get userClubId => _userClubId;

  Future saveAcesssToken(
      {String key = 'accessToken', required String value}) async {
    await Utils.sharedPrefrence(key: key, value: value);
  }

  Future<void> saveUserClubIdWhenClubcreate(String? clubId) async {
    await Utils.sharedPrefrence(key: 'userClubId', value: clubId ?? "");
    await getUserClubId();
  }

  Future<void> saveUserClubId(UserModel model) async {
    if (model.data?.club != null &&
        model.data?.clubStatus != null &&
        model.data!.club!.isNotEmpty &&
        model.data!.clubStatus!.isNotEmpty) {
      Utils.sharedPrefrence(key: "userClubId", value: model.data?.club ?? "");
    }
    await getUserClubId();
  }

  Future<void> getUserClubId() async {
    _userClubId = await Utils.sharedPrefrenceGetValue(key: 'userClubId');
    notifyListeners();
  }

  Future<String?> getUser() async {
    var authToken = await Utils.sharedPrefrenceGetValue(key: "authToken");
    notifyListeners();
    return authToken;
  }

  Future<bool> logoutRemoveAllData(BuildContext context) async {
    Provider.of<LogoutViewModel>(context, listen: false)
        .clearAllDatasLogout(context);
    final sp = await SharedPreferences.getInstance();
    await sp.remove('authToken');
    await sp.remove("userClubId");
    await sp.remove("accessToken");
    return true;
  }
}
