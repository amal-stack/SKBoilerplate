
import 'package:boilerplate/src/features/dashboard/data/models/dashboard_response.dart';
import 'package:boilerplate/src/features/dashboard/data/models/faqs_response.dart';

abstract interface class DashboardDataSource {
  Future<DashboardResponse> dashboardData();

  Future<FaqsResponse> faqs();
}
