import 'package:dio/dio.dart';

import 'api_client.dart';
import 'models/api_exception.dart';
import 'models/api_request.dart';
import 'models/api_response.dart';
import 'token_store.dart';

/// An implementation of [ApiClient] using the Dio HTTP client.
class DioApiClient implements ApiClient {
  DioApiClient(this._dio, this.tokenStore);

  DioApiClient.fromOptions(BaseOptions options, this.tokenStore)
    : _dio = Dio(options);

  final Dio _dio;

  final TokenStore tokenStore;

  @override
  Future<ApiResponse> fetch(String method, ApiRequest request) async {
    final token = await tokenStore.token();
    final options = _createOptions(method, token, request.headers);

    try {
      final response = await _dio.request<dynamic>(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: options,
      );

      return ApiResponse(data: response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      throw ApiException(message: e.message, error: e);
    }
  }

  @override
  Future<void> saveToken(String token)  {
    return tokenStore.saveToken(token);
  }

  @override
  Future<void> clearToken()  {
    return tokenStore.clearToken();
  }

  Options _createOptions(
    String method,
    String? token,
    Map<String, dynamic>? headers,
  ) => Options(
    method: method,
    headers: token != null
        ? {
            HttpAuthorizationHeader.name: HttpAuthorizationHeader.bearer(token),
            ...?headers,
          }
        : headers,
  );
}
