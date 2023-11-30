import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/src/splash/view_model/user_view_model.dart';
// import 'package:provider/provider.dart';

class SplashServices {
  Future<String?> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    // context.read<UserViewModel>().logoutRemoveAllData(context);
    getUserData().then((value) async {
      if (value == null || value.isEmpty) {
        await Future.delayed(const Duration(seconds: 3)).then((value) {
          Navigator.pushReplacementNamed(
            context,
            RoutesName.login,
          );
        });
      } else {
        await Future.delayed(const Duration(seconds: 3)).then((value) {
          Navigator.pushReplacementNamed(context, RoutesName.navigation);
        });
      }
    }).onError((error, stackTrace) {});
  }
}
