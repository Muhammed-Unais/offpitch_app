import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart';
import 'package:offpitch_app/data/app_exception.dart';
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:http/http.dart' as http;


class NetworkApiServices extends BaseApiService {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      Response response = await http.post(
          Uri.parse(
            url,
          ),
          body: data,
          headers: {}).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = jsonDecode(response.body);
        log(response.body);
        log(responseJson.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 403:
        throw UnauthorisedException(response.body);
      default:
        throw FetchDataException(
          'error occured while communicating with server${response.statusCode}',
        );
    }
  }

  // static getClub() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final token = preferences.getString('authToken');
  //   // Dio dio = Dio();
  //   try {
  //     log(token.toString());
  //     // dio.options.headers['Authorization'] = token;
  //     // final response = await dio.get("https://offpitch.live/api/auth/refresh");
  //     final headers = {'authToken': '$token'};
  //     final Response response = await http.get(
  //         Uri.parse("https://offpitch.live/api/auth/refresh"),
          
  //         headers: {});
  //     log(response.body.toString());
  //     // preferences.remove('accessToken');
  //   } catch (e) {
  //     log(e.toString());
  //     // preferences.remove('accessToken');

  //     // if (e.toString() == 403) {}
  //   }
  // }
}
