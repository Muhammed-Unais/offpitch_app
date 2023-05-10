import 'dart:developer';

import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/models/registration_fee_view_model.dart';
import 'package:offpitch_app/models/registration_model.dart';
import 'package:offpitch_app/models/registration_save_fee_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class RegistrationRepository {
  BaseApiService apiService = NetworkApiServices();

  Future<RegistrationFeeModel> postRegistration(id,RegistrationTour data) async {
    try {
      final response = await apiService.getPostApiWithAccessToken(
          "${AppUrl.scheduleTournament}/$id/register", registrationTourToJson(data));
      return registrationFeeModelFromJson(response);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future postPaymentSave(id,RegistrationSaveFeeModel data) async {
    try {
      final response = await apiService.getPostApiWithAccessToken(
          "${AppUrl.paymentSave}/$id/fee", registrationSaveFeeModelToJson(data));
      log(response.toString());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
