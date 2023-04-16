abstract class BaseApiService {
  Future<dynamic> getGetApiResponse(
    String url,id
  );
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getGetApiWithAccessToken(String url);
  Future<dynamic> getPostApiWithAccessToken(String url,dynamic data);
}
