
import 'package:boilerplate/src/features/products/data/models/response.dart';

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
}