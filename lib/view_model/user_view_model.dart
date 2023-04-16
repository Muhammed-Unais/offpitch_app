import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:offpitch_app/repository/club_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  final _myrepo = ClubRepository();
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

  Future getUser() async {
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

  Future club() async {
    _myrepo.getAllClubWithAccessTokem().then((value) {
      log(value.toString());
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
