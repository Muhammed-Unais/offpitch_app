import 'dart:developer';

import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/models/user_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class AuthRepository {
  final BaseApiService _apiService = NetworkApiServices();

  Future<UserModel> loginApi(dynamic data) async {
    try {
      final response =
          await _apiService.getPostApiResponse(AppUrl.loginEndPoint, data);

      return userModelFromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<dynamic> forgotPasswordApi(dynamic data) async {
    try {
      final response = await _apiService.getPostApiResponse(
          AppUrl.forgotPasswordEndPonint, data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> signupApi(dynamic data) async {
    try {
      final response =
          _apiService.getPostApiResponse(AppUrl.signupEndPoint, data);

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> otpVerifyApi(dynamic data) async {
    try {
      final response =
          _apiService.getPostApiResponse(AppUrl.otpVerifyEndPoint, data);

      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> userLogout() async {
    try {
      final response = _apiService.getGetApiResponse(AppUrl.userlogout, "");
      log(response.toString());
      return response;
    } catch (error) {
      
      log(error.toString());
      rethrow;
    }
  }
}
