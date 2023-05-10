
import 'package:offpitch_app/data/network/base_api_service.dart';
import 'package:offpitch_app/data/network/network_api_service.dart';
import 'package:offpitch_app/models/add_result_model.dart';
import 'package:offpitch_app/res/app_url.dart';

class AddResultRepository {
  BaseApiService apiService = NetworkApiServices();

  Future getPostAddResult(id, AddResultModel data) async {
    try {
      final response = await apiService.getPostApiWithAccessToken(
          "${AppUrl.addResult}/$id/result", addResultModelToJson(data));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
