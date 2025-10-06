
import 'package:boilerplate/src/features/dashboard/domain/entities/dashboard.dart';
import 'package:boilerplate/src/shared/models/faq.dart';

abstract interface class DashboardRepository {
  Future<Dashboard> dashboardData();

  Future<List<Faq>> faqs();
}