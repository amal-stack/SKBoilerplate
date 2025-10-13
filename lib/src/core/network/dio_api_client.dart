import 'package:boilerplate/src/core/network/models/api_exception.dart';
import 'package:dio/dio.dart';

import 'api_client.dart';
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

  final List<ApiErrorHandler> _errorHandlers = [];

  @override
  Future<ApiResponse> fetch(String method, ApiRequest request) async {
    final token = await tokenStore.token();
    final options = _createOptions(method, token, request.headers);

    final data = switch (request.data) {
      ApiFormData formData => await _createFormData(formData),
      _ => request.data,
    };

    try {
      final response = await _dio.request<dynamic>(
        request.path,
        data: data,
        queryParameters: request.queryParameters,
        options: options,
      );

      return ApiResponse(data: response.data, statusCode: response.statusCode);
    } on DioException catch (e) {
      final response = ApiResponse.error(
        failureType: _failureTypeFromDioException(e),
        error: e,
        message: switch (e.response?.data) {
          Map<String, dynamic> map => switch (map['message']) {
            String msg => msg,
            List<dynamic> msgs => msgs.join(', '),
            Map<String, dynamic> map => map.values.join(', '),
            final other? => other.toString(),
            null => 'An unknown error occurred while making the request.',
          },
          String msg => msg,
          List<dynamic> msgs => msgs.join(', '),
          final other? => other.toString(),
          null => 'An unknown error occurred while making the request.',
        },
        statusCode: e.response?.statusCode,
      );

      for (final handler in _errorHandlers) {
        handler(response.error!);
      }

      return response;
    }
  }

  @override
  Future<void> saveToken(String token) {
    return tokenStore.saveToken(token);
  }

  @override
  Future<void> clearToken() {
    return tokenStore.clearToken();
  }

  @override
  void addErrorHandler(ApiErrorHandler handler) {
    if (!_errorHandlers.contains(handler)) {
      _errorHandlers.add(handler);
    }
  }

  @override
  void removeErrorHandler(ApiErrorHandler handler) {
    _errorHandlers.remove(handler);
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

  Future<FormData> _createFormData(ApiFormData formData) async {
    return FormData.fromMap({
      ...formData.fields,
      for (final file in formData.files)
        file.key: switch (file.files) {
          [final singleFile] => await _createMultipartFile(singleFile),
          final multipleFiles => await Future.wait([
            for (final f in multipleFiles) _createMultipartFile(f),
          ]),
        },
    });
  }

  Future<MultipartFile> _createMultipartFile(ApiFile file) {
    return MultipartFile.fromFile(file.path, filename: file.filename);
  }
}

ApiFailureType _failureTypeFromDioException(DioException exception) =>
    switch (exception.type) {
      DioExceptionType.badResponse => ApiFailureType.fromStatusCode(
        exception.response?.statusCode,
      ),
      DioExceptionType.connectionTimeout => ApiFailureType.connectionTimeout,
      DioExceptionType.sendTimeout => ApiFailureType.sendTimeout,
      DioExceptionType.receiveTimeout => ApiFailureType.receiveTimeout,

      DioExceptionType.cancel => ApiFailureType.cancelled,

      DioExceptionType.connectionError => ApiFailureType.networkError,

      DioExceptionType.badCertificate ||
      DioExceptionType.unknown => ApiFailureType.unknownError,
    };
