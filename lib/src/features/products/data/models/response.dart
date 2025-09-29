import 'package:boilerplate/src/core/models/paginated_response.dart';
import 'package:boilerplate/src/features/products/domain/product.dart';

class ProductsResponse extends PaginatedResponse<Product> {
  const ProductsResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  ProductsResponse.fromJson(Map<String, dynamic> json)
    : super.fromJson(json, Product.fromJson, 'models');

  @override
  Map<String, dynamic> itemToJson(Product item) => item.toJson();
}
