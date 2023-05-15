import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:offpitch_app/view_model/logout_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveToken(UserModel userModel) async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('accessToken');
    sp.setString(
      'accessToken',
      userModel.data!.accessToken!,
    );
    notifyListeners();
    return true;
  }

  Future<String?> getUser() async {
    final sp = await SharedPreferences.getInstance();
    final String? authToken = sp.getString("authToken");
    log(authToken.toString());
    notifyListeners();
    return authToken;
  }

  Future<bool> logoutRemoveAllData(BuildContext context) async {
    Provider.of<LogoutViewModel>(context, listen: false)
        .clearAllDatasLogout(context);
    final sp = await SharedPreferences.getInstance();
    await sp.remove('authToken');
    await sp.remove("myClubId");
    await sp.remove("accessToken");
    return true;
  }
}
