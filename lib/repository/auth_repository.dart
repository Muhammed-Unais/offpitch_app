
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/res/app_url.dart';

class AuthRepository {
  final BaseApiService _apiService = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      final response =
          await _apiService.getPostApiResponse(AppUrl.loginEndPoint, data);
          
      return response;
    } catch (e) {
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

}
