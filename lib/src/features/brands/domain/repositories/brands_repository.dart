
import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/shared/paginated.dart';

abstract interface class BrandsRepository {
  Future<Paginated<Brand>> allBrands({int? page, int? limit});

  Future<Paginated<Brand>> search(String query, {int? page, int? limit});
}