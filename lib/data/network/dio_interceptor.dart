import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:offpitch_app/data/network/http_helpor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInterceptor {
  var dio = Dio();
  static String baseUrl = "https://offpitch.live/api";

  AppInterceptor() {
    dio.options =
        BaseOptions(contentType: 'application/json', baseUrl: baseUrl);

    dio.interceptors.add(
      InterceptorsWrapper(
        // on request method===================
        onRequest: (RequestOptions requestOptions,
            RequestInterceptorHandler handler) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final accessToken = preferences.getString('accessToken');
          requestOptions.headers
              .putIfAbsent('Authorization', () => 'Bearer $accessToken');
          handler.next(requestOptions);
        },

        // OnError method =====================
        onError: (DioError err, ErrorInterceptorHandler handler) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          final accessToken = preferences.getString('accessToken');

          //
          if (err.response?.statusCode == 401 ||
              err.response?.statusCode == 403) {
            log("Refreshing Token");

            // ignore: deprecated_member_use
            dio.interceptors.requestLock.lock();
            // ignore: deprecated_member_use
            dio.interceptors.responseLock.lock();

            if (accessToken != "") {
              Response<dynamic> response = await HttpHelpor.refreshToken();
              if (response.statusCode == 200) {
                log("New Token Received: ${response.data}");
                final accessToken = response.data['data']['accessToken'];
                log("newAccessToken     $accessToken");
                preferences.remove('accessToken');
                await preferences.setString('accessToken', accessToken);
                // ignore: deprecated_member_use
                dio.interceptors.requestLock.unlock();
                // ignore: deprecated_member_use
                dio.interceptors.responseLock.unlock();
                RequestOptions options = err.requestOptions;
                log("new Request================");
                try {
                log("new Request=======ssssssss=========");
                  var resp = await dio.request(err.requestOptions.path,
                      data: options.data,
                      cancelToken: options.cancelToken,
                      onReceiveProgress: options.onReceiveProgress,
                      onSendProgress: options.onSendProgress,
                      queryParameters: options.queryParameters);
                  handler.resolve(resp);
                } on DioError catch (error) {
                  handler.reject(error);
                }

                // else case==============
              } else {
                log("Error refreshing token: ${response.statusCode}");
                // ignore: deprecated_member_use
                dio.interceptors.requestLock.unlock();
                // ignore: deprecated_member_use
                dio.interceptors.responseLock.unlock();
                handler.reject(err);
              }
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
