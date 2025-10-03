import 'package:boilerplate/src/features/dashboard/data/data_sources/dashboard_data_source.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/dashboard.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/faq.dart';
import 'package:boilerplate/src/features/dashboard/domain/repositories/dashboard_repository.dart';

class RemoteDashboardRepository implements DashboardRepository {
  const RemoteDashboardRepository(this.dataSource);

  final DashboardDataSource dataSource;

  @override
  Future<Dashboard> dashboardData() =>
      dataSource.dashboardData().then((response) => response.data!);

  @override
  Future<List<Faq>> faqs() =>
      dataSource.faqs().then((response) => response.data!);
}
