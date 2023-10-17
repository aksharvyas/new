abstract class BaseApiService {
  final String BASE_URL = "http://122.169.109.79:9110/api/";

  Future<dynamic> getResponse(String url);

  Future<dynamic> getResponseWithoutToken(String url);

  Future<dynamic> postResponse(String url,dynamic request);

  Future<dynamic> postResponseWithToken(String url,dynamic request);
}
