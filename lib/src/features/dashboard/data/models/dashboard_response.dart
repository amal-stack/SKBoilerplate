import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/dashboard.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/faq.dart';

class DashboardResponse {
  const DashboardResponse({
    required this.success,
    required this.message,
    required this.data,
    
  });

  final Dashboard data; 

  final int success;

  final String message;

  DashboardResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as int,
      message = json['message'] as String,
      data = Dashboard.fromJson(json);


  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    ...data.toJson(),
  };
}
