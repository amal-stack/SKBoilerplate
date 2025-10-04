import 'package:boilerplate/src/features/dashboard/domain/entities/faq.dart';

class FaqsResponse {
  const FaqsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final int success;

  final String message;

  final List<Faq> data;

  FaqsResponse.fromJson(Map<String, dynamic> json)
    : data = [
        for (final faq in (json['data'] as List<dynamic>? ?? (throw Exception('FAQs data is ${json['data']} but should be List'))))
          Faq.fromJson(faq as Map<String, dynamic>),
      ],
      success = json['success'] as int,
      message = json['message'] as String;

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'data': [for (final faq in data) faq.toJson()],
  };
}
