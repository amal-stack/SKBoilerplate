import 'package:boilerplate/src/features/products/data/data_sources/products_data_source.dart';
import 'package:boilerplate/src/features/products/domain/product.dart';
import 'package:boilerplate/src/features/products/domain/product_variant.dart';
import 'package:boilerplate/src/features/products/domain/repositories/products_repository.dart';
import 'package:boilerplate/src/shared/paginated.dart';

class RemoteProductsRepository implements ProductsRepository {
  const RemoteProductsRepository(this.dataSource);

  final ProductsDataSource dataSource;

  @override
  Future<Paginated<Product>> products({
    required String brandId,
    int? page,
    int? limit,
  }) => dataSource
      .products(brandId: brandId, page: page, limit: limit)
      .then((response) => response.toPaginated());

  @override
  Future<List<ProductVariant>> variants({
    required String modelId,
  }) => dataSource
      .variants(modelId: modelId,)
      .then((response) => response.data!);
}
