import 'package:boilerplate/src/core/models/data_response.dart';
import 'package:boilerplate/src/core/models/paginated_response.dart';
import 'package:boilerplate/src/features/products/domain/product.dart';
import 'package:boilerplate/src/features/products/domain/product_variant.dart';

class ProductsResponse extends PaginatedResponse<Product> {
  const ProductsResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  ProductsResponse.fromJson(super.json)
    : super.fromJson(itemFromJson: Product.fromJson, itemsKey: 'models');

  @override
  Map<String, dynamic> itemToJson(Product item) => item.toJson();
}

class ProductVariantsResponse extends ListDataResponse<ProductVariant> {
  const ProductVariantsResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  ProductVariantsResponse.fromJson(super.json)
    : super.fromJson(
        itemFromJson: ProductVariant.fromJson,
        itemsKey: 'variantOptions',
      );

  @override
  Map<String, dynamic> itemToJson(ProductVariant item) => item.toJson();
}
