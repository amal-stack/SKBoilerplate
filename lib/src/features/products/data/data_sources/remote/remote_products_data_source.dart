import 'package:boilerplate/src/core/config/api_options.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/products/data/data_sources/products_data_source.dart';
import 'package:boilerplate/src/features/products/data/models/response.dart';

String _baseUrl(String brandId) =>
    '${ApiOptions.baseUrl}/devices/brands/$brandId/models';

class RemoteProductsDataSource implements ProductsDataSource {
  const RemoteProductsDataSource(this._client);

  final ApiClient _client;

  @override
  Future<ProductsResponse> products({
    required String brandId,
    int? page,
    int? limit,
  }) async {
    final response = await _client.get(
      ApiRequest(
        path: _baseUrl(brandId),
        queryParameters: {
          if (page != null) 'page': page,
          if (limit != null) 'limit': limit,
        },
      ),
    );

    return ProductsResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
