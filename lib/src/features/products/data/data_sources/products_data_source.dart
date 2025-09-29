
import 'package:boilerplate/src/core/models/paginated_response.dart';
import 'package:boilerplate/src/features/products/domain/product.dart';

abstract interface class ProductsDataSource {
  Future<PaginatedResponse<Product>> products({
    required String brandId,
    int? page,
    int? limit,
  });
}