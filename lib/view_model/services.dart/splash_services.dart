import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/view_model/user_view_model.dart';

class SplashServices {
  Future getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async {
      log("value=======$value");
      if (value == "" || value == null) {
        await Future.delayed(const Duration(seconds: 3));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(
          context,
          RoutesName.login,
        );
      } else {
        await Future.delayed(const Duration(seconds: 3));
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, RoutesName.navigation
        );
      }
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
