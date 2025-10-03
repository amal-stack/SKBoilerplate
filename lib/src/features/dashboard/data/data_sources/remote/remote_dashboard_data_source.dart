import 'package:boilerplate/src/core/config/api_options.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/dashboard/data/data_sources/dashboard_data_source.dart';
import 'package:boilerplate/src/features/dashboard/data/models/dashboard_response.dart';
import 'package:boilerplate/src/features/dashboard/data/models/faqs_response.dart';

class RemoteDashboardDataSource implements DashboardDataSource {
  const RemoteDashboardDataSource(this._client);

  final ApiClient _client;

  static const String _url = '${ApiOptions.baseUrl}/dashboard';

  @override
  Future<DashboardResponse> dashboardData() => _client
      .get(ApiRequest(path: _url))
      .then((response) => response.data as Map<String, dynamic>)
      .then(DashboardResponse.fromJson);

  @override
  Future<FaqsResponse> faqs() => _client
      .get(ApiRequest(path: '$_url/load-more-faq'))
      .then((response) => response.data as Map<String, dynamic>)
      .then(FaqsResponse.fromJson);
}
