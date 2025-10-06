import 'package:boilerplate/src/core/models/paginated_response.dart';
import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';

class BrandsResponse extends PaginatedResponse<Brand> {
  const BrandsResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  BrandsResponse.fromJson(super.json)
    : super.fromJson(itemFromJson: Brand.fromJson, itemsKey: 'brands');

  @override
  Map<String, dynamic> itemToJson(Brand item) => item.toJson();
}
