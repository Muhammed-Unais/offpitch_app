import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:offpitch_app/data/app_exception.dart';
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/dio_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkApiServices extends BaseApiService {
  @override
  Future getGetApiResponse(String url,id) async {
     log(url);
    final dio = Dio();
    log("-----------------");
    dynamic responseJson;
    try {
      final response = await dio.get(url+id).timeout(
            const Duration(
              seconds: 10,
            ),
          );

     
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    final dio = Dio();
    dynamic responseJson;
    try {
      Response response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 10));

      if (response.headers.map.containsKey('set-cookie')) {
        log("=====");
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
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = response.data;
        log(responseJson.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.data);
      case 403:
        throw UnauthorisedException(response.data);
      default:
        throw FetchDataException(
          'error occured while communicating with server${response.statusCode}',
        );
    }
  }

  @override
  Future getGetApiWithAccessToken(String url) async {
    final dio = Dio();
    final appinterceptor = AppInterceptor();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    dio.interceptors.addAll(appinterceptor.dio.interceptors);
    try {
      final accessToken = preferences.getString("accessToken");
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      log(accessToken.toString());
      final response = await dio.get(url);
      log("=========================");
      log(response.data.toString());
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      log(e.toString());
      return e;
    }
  }

  @override
  Future getPostApiWithAccessToken(String url, data) async{
    throw UnimplementedError();
  }
}
