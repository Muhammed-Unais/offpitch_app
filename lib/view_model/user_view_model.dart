import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  // final _myrepo = AuthRepository();
  Future<bool> saveToken(UserModel userModel) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(
      'accessToken',
      userModel.data!.accessToken!,
    );
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final sp = await SharedPreferences.getInstance();
    final String? accessToken = sp.getString("accessToken");

    return UserModel(data: Data(accessToken: accessToken));
  }

  Future<bool> remove() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove('accessToken');
    return true;
  }
}
