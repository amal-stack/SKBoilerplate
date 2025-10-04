class ApiRequest {
  const ApiRequest({
    required this.path,
    this.data,
    this.queryParameters,
    this.headers,
  });
  final String path;
  final Object? data;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? headers;

  ApiRequest copyWith({
    String? path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) => ApiRequest(
    path: path ?? this.path,
    data: data ?? this.data,
    queryParameters: queryParameters ?? this.queryParameters,
    headers: headers ?? this.headers,
  );
}
