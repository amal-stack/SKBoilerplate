abstract final class ApiOptions {
  static const String baseUrl = 'https://api.sk.andaihub.ai/api';

  static const Duration connectTimeout = Duration(seconds: 5);

  static const Duration sendTimeout = Duration(seconds: 5);

  static const Duration receiveTimeout = Duration(seconds: 5);
}
