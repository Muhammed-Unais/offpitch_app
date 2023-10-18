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
      await Utils.sharedPrefrence(
                    key: "accessToken", value: accessToken);
      return accessToken;
    } catch (e) {
      Utils.sharedClearAll();
      navigatorKey.currentState
          ?.pushNamedAndRemoveUntil(RoutesName.login, (route) => false);
    }
    return null;
  }
}
