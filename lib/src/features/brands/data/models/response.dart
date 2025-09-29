import 'package:boilerplate/src/core/models/paginated_response.dart';
import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';

class BrandsResponse extends PaginatedResponse<Brand> {
  const BrandsResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  BrandsResponse.fromJson(Map<String, dynamic> json)
    : super.fromJson(json, Brand.fromJson, 'brands');

  @override
  Map<String, dynamic> itemToJson(Brand item) => item.toJson();
}
