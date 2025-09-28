import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: '',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  static Future<Map<String, dynamic>> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      dio!.options.headers = headers ?? dio!.options.headers;

      Response response = await dio!.get(
        url,
        queryParameters: query,
      );

      return _handleResponse(response);
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }

  static Future<Map<String, dynamic>> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      dio!.options.headers = headers ?? dio!.options.headers;

      Response response = await dio!.post(
        url,
        data: data,
      );

      return _handleResponse(response);
    } on DioError catch (error) {
      return _handleDioError(error);
    }
  }

  // Handle successful and error HTTP responses
  static Map<String, dynamic> _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return {
        'success': true,
        'data': response.data,
        'statusCode': response.statusCode,
      };
    } else {
      return {
        'success': false,
        'message': response.statusMessage,
        'statusCode': response.statusCode,
      };
    }
  }

  // Handle Dio errors like 400, 404, 500 etc.
  static Map<String, dynamic> _handleDioError(DioError error) {
    return {
      'success': false,
      'message': error.response?.data ?? error.message,
      'statusCode': error.response?.statusCode ?? -1,
    };
  }
}
