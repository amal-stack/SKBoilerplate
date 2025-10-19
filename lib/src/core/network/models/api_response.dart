import 'package:boilerplate/src/core/network/models/api_exception.dart';
import 'package:meta/meta.dart';

/// A class representing a generic API response.
@immutable
class ApiResponse {
  const ApiResponse({required Object data, required this.statusCode})
    : error = null, _providedData = data;

  ApiResponse.error({
    required Object error,
    required ApiFailureType failureType,
    String? message,
    this.statusCode,
  }) : error = ApiException(
         error: error,
         message: message,
         statusCode: statusCode,
         failureType: failureType,
       ),
       _providedData = null;

  ApiResponse.fromJson(Map<String, dynamic> json)
    : _providedData = json['data'],
      statusCode = json['statusCode'] as int?,
      error = null;

  final Object? _providedData;

  /// The data returned from the API, if any.
  Object get data => _providedData ?? (throw error!);

  Object? get maybeData => _providedData;

  T dataAs<T>() => data as T;

  T? maybeDataAs<T>() => data as T?;

  Map<String, dynamic> dataAsMap() => data as Map<String, dynamic>;

  Map<String, dynamic>? maybeDataAsMap() => switch (data) {
    Map<String, dynamic> map => map,
    _ => null,
  };

  /// The error, if any.
  final ApiException? error;

  /// The HTTP status code of the response, if available.
  final int? statusCode;

  /// Indicates whether the response was successful.
  bool get isSuccess => error == null;

  /// Indicates whether the response status code represents a successful operation.
  ///
  /// A status code in the range 200-299 is considered successful.
  bool get isSuccessStatusCode => switch (statusCode) {
    null => false,
    >= 200 && < 300 => true,
    _ => false,
  };

  @override
  String toString() => 'ApiResponse(data: $data, statusCode: $statusCode)';
}


sealed class ApiAuthenticationStatus {
  const ApiAuthenticationStatus();

  const factory ApiAuthenticationStatus.authenticated([Object? user]) = ApiAuthenticated;

  const factory ApiAuthenticationStatus.unauthenticated([String? error]) = ApiUnauthenticated;

  const factory ApiAuthenticationStatus.unknown() = ApiUnknownAuthentication;

}

class ApiAuthenticated extends ApiAuthenticationStatus {
  const ApiAuthenticated([this.user]);

  final Object? user;
}

class ApiUnauthenticated extends ApiAuthenticationStatus {
  const ApiUnauthenticated([this.error]);
  final String? error;
}

class ApiUnknownAuthentication extends ApiAuthenticationStatus {
  const ApiUnknownAuthentication();
}