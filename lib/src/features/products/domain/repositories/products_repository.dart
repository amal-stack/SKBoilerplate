
import 'package:boilerplate/src/features/products/domain/product.dart';
import 'package:boilerplate/src/shared/paginated.dart';

abstract interface class ProductsRepository {
  Future<Paginated<Product>> products({
    required String brandId,
    int? page,
    int? limit,
  });
}