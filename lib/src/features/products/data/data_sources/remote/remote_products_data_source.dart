import 'package:boilerplate/src/core/config/api_options.dart';
import 'package:boilerplate/src/core/network/api_client.dart';
import 'package:boilerplate/src/core/network/models/api_request.dart';
import 'package:boilerplate/src/features/products/data/data_sources/products_data_source.dart';
import 'package:boilerplate/src/features/products/data/models/response.dart';

String _productsUrl(String brandId) =>
    '${ApiOptions.baseUrl}/devices/brands/$brandId/models';

String _variantsUrl(String modelId) =>
    '${ApiOptions.baseUrl}/devices/models/$modelId/variants';

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
        path: _productsUrl(brandId),
        queryParameters: {
          if (page != null) 'page': page,
          if (limit != null) 'limit': limit,
        },
      ),
    );

    return ProductsResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ProductVariantsResponse> variants({
    required String modelId
  }) async {
    final response = await _client.get(
      ApiRequest(
        path: _variantsUrl(modelId),
      ),
    );

    return ProductVariantsResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
