class ApiException implements Exception {
  const ApiException({String? message, this.error, this.statusCode})
    : message = message ?? 'Unknown request error';

  final String message;
  final Object? error;
  final int? statusCode;

  @override
  String toString() =>
      'ApiException: $message (error: $error, statusCode: $statusCode)';
}
