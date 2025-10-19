
import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/features/products/data/models/response.dart';
import 'package:boilerplate/src/features/products/domain/product_variant.dart';

abstract interface class ProductsDataSource {
  Future<ProductsResponse> products({
    required String brandId,
    int? page,
    int? limit,
    String? search,
  });

  Future<ProductVariantsResponse> variants({
    required String modelId,
  });

  Future<ListDataResponse<DevicePricing>> pricing({
    required String variantId,
  });
}