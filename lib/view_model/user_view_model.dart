import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
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

  Future<bool> remove() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('authToken');
    return true;
  }
}
