import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/view_model/logout_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  String? _userClubId;
  String? get userClubId => _userClubId;
  String? _userClubStatus;
  String? get userClubStatus => _userClubStatus;

  Future saveAcesssToken(
      {String key = 'accessToken', required String value}) async {
    await Utils.sharedPrefrence(key: key, value: value);
  }

  Future<void> saveUserClubIdWhenClubcreate(
      String? clubId, String? clubStatus) async {
    await Utils.sharedPrefrence(key: 'userClubId', value: clubId ?? "");
    await Utils.sharedPrefrence(key: "userClubStatus", value: clubStatus ?? "");
  }

  Future<void> saveUserClubId(UserModel model) async {
    if (model.data?.club != null &&
        model.data?.clubStatus != null &&
        model.data!.club!.isNotEmpty &&
        model.data!.clubStatus!.isNotEmpty) {
      Utils.sharedPrefrence(key: "userClubId", value: model.data?.club ?? "");
      Utils.sharedPrefrence(
          key: "userClubStatus", value: model.data?.clubStatus ?? "");
    }
    await getUserClubId();
  }

  Future<void> getUserClubId() async {
    _userClubId = await Utils.sharedPrefrenceGetValue(key: 'userClubId');

    _userClubStatus =
        await Utils.sharedPrefrenceGetValue(key: 'userClubStatus');

    notifyListeners();
  }

  Future<String?> getUser() async {
    var authToken = await Utils.sharedPrefrenceGetValue(key: "authToken");
    notifyListeners();
    return authToken;
  }

  Future<bool> logoutRemoveAllData(BuildContext context) async {
    _userClubStatus = null;
    _userClubId = null;
    context.read<LogoutViewModel>().clearAllDatasLogout(context);
    final sp = await SharedPreferences.getInstance();
    await sp.remove('authToken');
    await sp.remove("userClubId");
    await sp.remove("accessToken");
    await sp.remove("userClubStatus");
    return true;
  }
}
