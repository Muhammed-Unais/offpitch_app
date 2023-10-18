import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:offpitch_app/data/network/http_helpor.dart';
import 'package:offpitch_app/utils/utils.dart';

class AppInterceptor {
  var dio = Dio();
  final String _baseUrl = "https://offpitch-api.onrender.com/api";

  AppInterceptor() {
    dio.options =
        BaseOptions(contentType: 'application/json', baseUrl: _baseUrl);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) async {
          final accessToken =
              await Utils.sharedPrefrenceGetValue(key: 'accessToken');
          requestOptions.headers
              .putIfAbsent('Authorization', () => 'Bearer $accessToken');
          handler.next(requestOptions);
        },
        onError: (err, handler) async {
          log(err.response?.statusCode.toString() ??"statuscode");
          if (err.response?.statusCode == 401 ||
              err.response?.statusCode == 403) {
            final newAccessToken = await HttpHelpor().refreshToken();

            if (newAccessToken != null) {
              err.requestOptions.headers["Authorization"] =
                  'Bearer $newAccessToken';
              return handler.resolve(await dio.fetch(err.requestOptions));
            } else {
              handler.reject(err);
            }
          } else {
            handler.reject(err);
          }
        },
      ),
    );
  }
}
