class ApiException implements Exception {
  const ApiException({
    String? message,
    required this.failureType,
    this.error,
    this.statusCode,
  }) : _providedMessage = message;

  final String? _providedMessage;

  final Object? error;
  final int? statusCode;
  final ApiFailureType failureType;

  String get message => _providedMessage ?? failureType.toString();

  @override
  String toString() =>
      'ApiException: $message (error: $error, statusCode: $statusCode, failureType: $failureType)';
}

enum ApiFailureType {
  /// The request was cancelled.
  cancelled,

  /// A connection timeout occurred.
  connectionTimeout,

  /// A send timeout occurred.
  sendTimeout,

  /// A receive timeout occurred.
  receiveTimeout,

  /// An unknown error occurred.
  unknown,

  // Status code errors:
  /// The request was malformed.
  badRequest, // 400

  /// The request was not authorized.
  unauthorized, // 401

  /// The requested resource was not found.
  notFound, // 404

  /// Another client error occurred.
  clientError, // 4xx

  /// A server error occurred.
  serverError, // 5xx

  /// A network error occurred.
  networkError,

  /// Unknown error
  unknownError;

  factory ApiFailureType.fromStatusCode(int? statusCode) =>
      switch (statusCode) {
        null => ApiFailureType.unknownError,
        400 => ApiFailureType.badRequest,
        401 => ApiFailureType.unauthorized,
        404 => ApiFailureType.notFound,
        >= 400 && < 500 => ApiFailureType.clientError,
        >= 500 && < 600 => ApiFailureType.serverError,
        _ => ApiFailureType.unknownError,
      };

  @override
  String toString() => switch (this) {
    ApiFailureType.unknown => 'Unknown error occurred',
    ApiFailureType.cancelled => 'Request was cancelled',
    ApiFailureType.connectionTimeout => 'Connection timeout occurred',
    ApiFailureType.sendTimeout => 'Send timeout occurred',
    ApiFailureType.receiveTimeout => 'Receive timeout occurred',
    ApiFailureType.badRequest => 'Bad request',
    ApiFailureType.unauthorized => 'Not authorized',
    ApiFailureType.notFound => 'Resource not found',
    ApiFailureType.clientError => 'Client error occurred',
    ApiFailureType.serverError => 'Server error occurred',
    ApiFailureType.networkError => 'Network error occurred',
    ApiFailureType.unknownError => 'Unknown error occurred',
  };
}
