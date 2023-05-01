abstract class BaseApiService {
  Future<dynamic> getGetApiResponse(
    String url,queries
  );
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getGetApiWithAccessToken(String url);
  Future<dynamic> getPutApiWithAccessToken(String url,dynamic data);
  Future<dynamic> getPostApiWithAccessToken(String url,dynamic data);
}
