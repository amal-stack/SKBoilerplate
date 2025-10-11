import 'package:boilerplate/src/core/config/api_options.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/brands/data/data_sources/brands_data_source.dart';
import 'package:boilerplate/src/features/brands/data/models/response.dart';

const _baseUrl = '${ApiOptions.baseUrl}/devices/brands';

class RemoteBrandsDataSource implements BrandsDataSource {
  const RemoteBrandsDataSource(this._client);

  final ApiClient _client;

  @override
  Future<BrandsResponse> brands({int? page, int? limit, String? search}) async {
    final response = await _client.get(
      ApiRequest(
        path: _baseUrl,
        queryParameters: {
          if (page != null) 'page': page,
          if (limit != null) 'limit': limit,
          if (search != null) 'search': search,
        },
      ),
    );

    return BrandsResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
