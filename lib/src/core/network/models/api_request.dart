
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

class ApiFileEntry {
  ApiFileEntry({required this.key, required String path, required String filename})
    : files = [ApiFile(path: path, filename: filename)];

  ApiFileEntry.multiple({required this.key, required this.files});

  final String key;

  final List<ApiFile> files;
}

class ApiFile {
  const ApiFile({required this.path, required this.filename});

  final String path;

  final String filename;
}

class ApiFormData {
  const ApiFormData({required this.fields, required this.files});

  final Map<String, dynamic> fields;

  final List<ApiFileEntry> files;
}
