import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:offpitch_app/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api extends ChangeNotifier{
  final Dio api = Dio();
  String? accessToken;

  Api() {
    api.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      if (!options.path.contains('https')) {
        options.path = '${AppUrl.baseUrl}${options.path}';
      }
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }, onError: (DioError error, handler) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if ((error.response?.statusCode == 403)) {
        if (preferences.containsKey('accessToken')) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
      }
      return handler.next(error);
    }));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  Future<bool> refreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    final response = await api.get('${AppUrl.baseUrl}/auth/refresh');

    if (response.statusCode == 200) {
      await preferences.clear();
      accessToken = response.data;
      await preferences.setString('accessToken', accessToken!);
      return true;
    } else {
      // refresh token is wrong
      accessToken = null;
      await preferences.clear();
      return false;
    }
  }
}
