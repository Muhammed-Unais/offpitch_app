
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:offpitch_app/data/app_exception.dart';
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/dio_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiServices extends BaseApiService {
//  Get api Method without accessToken====================

  @override
  Future getGetApiResponse(String url, queries) async {
    log(url);
    final dio = Dio();
    dynamic responseJson;

    try {
      final response =
          await dio.get(url + queries).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
      return responseJson;
    } on DioError catch (e) {
      return returnResponse(e.response);
    }
  }

//  post api Method without accessToken====================
  @override
  Future getPostApiResponse(String url, dynamic data) async {
    final dio = Dio();
    dynamic responseJson;

    try {
      Response response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 10));
      if (response.headers.map.containsKey('set-cookie')) {
        final cookies = response.headers.map['set-cookie'];
        log(cookies.toString());

        if (cookies!.isNotEmpty) {
          final authToken = cookies[0].split('=')[1].split(';')[0];
          log(authToken.toString());
          final sp = await SharedPreferences.getInstance();
          sp.setString('authToken', authToken);
        }
      }

      responseJson = returnResponse(response);
      return responseJson;
    } on DioError catch (e) {
      return returnResponse(e.response);
    }
  }

// get api Method with accessToken====================
  @override
  Future getGetApiWithAccessToken(String url) async {
    final dio = Dio();
    final appinterceptor = AppInterceptor();

    dynamic successResponseData;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    dio.interceptors.addAll(appinterceptor.dio.interceptors);

    try {
      final accessToken = preferences.getString("accessToken");
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      final response = await dio.get(url);
      successResponseData = returnResponse(response);

      return successResponseData;
    } on DioError catch (e) {
      return returnResponse(e.response);
    }
  }

// Put Api method with AccessToken=====================
  @override
  Future getPutApiWithAccessToken(String url, data) async {
    dynamic successResponseData;

    final dio = Dio();
    final appinterceptor = AppInterceptor();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    dio.interceptors.addAll(appinterceptor.dio.interceptors);

    try {
      final accessToken = preferences.getString("accessToken");

      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      final response =
          await dio.put(url, data: data).timeout(const Duration(seconds: 10));

      successResponseData = returnResponse(response);
      return successResponseData;
    } on DioError catch (e) {
      return returnResponse(e.response);
    }
  }

//  return Response based on api response states code
  returnResponse(Response<dynamic>? response) {
    if (response != null) {
      switch (response.statusCode) {
        case 200:
          final responseJson = response.data;
          log(responseJson.toString());
          return responseJson;
        case 400:
          throw BadRequestException(response.data['message']);
        case 401:
          throw UnauthorisedException(response.data['message']);
        case 500:
          throw FetchDataException('Server error');  
        default:
          throw FetchDataException(
            response.data['message'],
          );
      }
    } else {
      throw FetchDataException('No internet connection');
    }
  }
}
