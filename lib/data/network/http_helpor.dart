import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpHelpor {
  static final dio = Dio();

  static Future<Response> refreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final authToken = preferences.getString('authToken');
    log(authToken.toString());
    return await dio.get(AppUrl.refreshToken,
        options: Options(headers: {'authToken': '$authToken'}));
  }
}
