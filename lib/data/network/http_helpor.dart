import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:offpitch_app/utils/utils.dart';

class HttpHelpor {
  static final dio = Dio();

  static Future<Response> refreshToken() async {
    final authToken =await Utils.sharedPrefrenceGetValue(key: "authToken");
    log(authToken.toString());
    return await dio.get(
      AppUrl.refreshToken,
      options: Options(
        headers: {'authToken': '$authToken'},
      ),
    );
  }
}
