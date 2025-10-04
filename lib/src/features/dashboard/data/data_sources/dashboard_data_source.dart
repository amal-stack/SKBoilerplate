
import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/paginated_response.dart';
import 'package:boilerplate/src/features/dashboard/data/models/dashboard_response.dart';
import 'package:boilerplate/src/features/dashboard/data/models/faqs_response.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/faq.dart';

abstract interface class DashboardDataSource {
  Future<DashboardResponse> dashboardData();

  Future<FaqsResponse> faqs();
}
