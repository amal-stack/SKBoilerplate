import 'models/api_request.dart';
import 'models/api_response.dart';

/// Interface for an API client to perform HTTP requests.
abstract interface class ApiClient {
  Future<ApiResponse> fetch(String method, ApiRequest request);

  Future<void> saveToken(String token);
}

/// Extension methods for common HTTP methods on the ApiClient.
extension ApiClientExtensions on ApiClient {
  Future<ApiResponse> get(ApiRequest request) => fetch(HttpVerbs.get, request);

  Future<ApiResponse> post(ApiRequest request) => fetch(HttpVerbs.post, request);

  Future<ApiResponse> put(ApiRequest request) => fetch(HttpVerbs.put, request);

  Future<ApiResponse> patch(ApiRequest request) => fetch(HttpVerbs.patch, request);

  Future<ApiResponse> delete(ApiRequest request) => fetch(HttpVerbs.delete, request);
}

class HttpVerbs {
  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String patch = 'PATCH';
  static const String delete = 'DELETE';
}


class HttpAuthorizationHeader {
  static const String name = 'Authorization';
  static const String bearerPrefix = 'Bearer ';

  static String bearer(String token) => '$bearerPrefix$token';
}


