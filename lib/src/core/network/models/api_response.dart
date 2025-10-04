import 'package:meta/meta.dart';

/// A class representing a generic API response.
@immutable
class ApiResponse {
  const ApiResponse({required this.data, required this.statusCode});

  ApiResponse.fromJson(Map<String, dynamic> json)
    : data = json['data'],
      statusCode = json['statusCode'] as int?;

  /// The data returned from the API, if any.
  final dynamic data;

  /// The HTTP status code of the response, if available.
  final int? statusCode;

  /// Indicates whether the response status code represents a successful operation.
  /// 
  /// A status code in the range 200-299 is considered successful.
  bool get isSuccess => switch (statusCode) {
    null => false,
    >= 200 && < 300 => true,
    _ => false,
  };

  @override
  String toString() => 'ApiResponse(data: $data, statusCode: $statusCode)';
}
