import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:offpitch_app/main.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:offpitch_app/utils/routes/routes_name.dart';
import 'package:offpitch_app/utils/utils.dart';

class HttpHelpor {
  final dio = Dio();
  Future<String?> refreshToken() async {
    final authToken = await Utils.sharedPrefrenceGetValue(key: "authToken");
    try {
      Response response = await dio.get(
        AppUrl.refreshToken,
        options: Options(headers: {'authToken': '$authToken'}),
      );
      final accessToken = response.data['data']['accessToken'] as String;
      log(accessToken.toString());
      await Utils.sharedPrefrence(key: "accessToken", value: accessToken);
      return accessToken;
    } on DioException catch (error) {
      var code = error.response?.statusCode;
      log(code.toString());
      if (code == 401 || code == 403) {
        Utils.sharedClearAll();
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil(RoutesName.login, (route) => false);
      }
    }
    return null;
  }
}
