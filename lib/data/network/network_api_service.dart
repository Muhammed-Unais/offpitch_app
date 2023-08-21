import 'package:dio/dio.dart';
import 'package:offpitch_app/data/app_exception.dart';
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/app_interceptor.dart';
import 'package:offpitch_app/utils/utils.dart';

class NetworkApiServices extends BaseApiService {
//  Get api Method without accessToken====================

  @override
  Future getGetApiResponse(String url, queries) async {
    final dio = Dio();
    dynamic responseJson;

    try {
      final response = await dio.get(url + queries);
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
      Response response = await dio.post(url, data: data);

      if (response.headers.map.containsKey('set-cookie')) {
        final cookies = response.headers.map['set-cookie'];
        if (cookies != null) {
          if (cookies.isNotEmpty) {
            final authToken = cookies[0].split('=')[1].split(';')[0];
            Utils.sharedPrefrence(key: 'authToken', value: authToken);
          }
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

    dio.interceptors.addAll(appinterceptor.dio.interceptors);

    try {
      final accessToken = Utils.sharedPrefrenceGetValue(key: 'accessToken');
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

    dio.interceptors.addAll(appinterceptor.dio.interceptors);

    try {
      final accessToken =await Utils.sharedPrefrenceGetValue(key: 'accessToken');

      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      final response = await dio.put(url, data: data).timeout(
            const Duration(seconds: 10),
          );

      successResponseData = returnResponse(response);
      return successResponseData;
    } on DioError catch (e) {
      return returnResponse(e.response);
    }
  }

// Post Api method with AccessToken=====================
  @override
  Future getPostApiWithAccessToken(String url, data) async {
    dynamic successResponseData;

    final dio = Dio();
    final appinterceptor = AppInterceptor();
    dio.interceptors.addAll(appinterceptor.dio.interceptors);

    try {
      final accessToken =await Utils.sharedPrefrenceGetValue(key: 'accessToken');

      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      final response =
          await dio.post(url, data: data).timeout(const Duration(seconds: 10));

      returnResponse(response);
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
          return responseJson;
        case 400:
          throw BadRequestException(response.data['message']);
        case 401:
          throw UnauthorisedException(response.data['message']);
        case 403:
          throw "Your Session Expired";
        case 500:
          throw FetchDataException('Something went wrong');
        default:
          throw FetchDataException(response.statusMessage);
      }
    } else {
      throw FetchDataException('No internet connection');
    }
  }
}
