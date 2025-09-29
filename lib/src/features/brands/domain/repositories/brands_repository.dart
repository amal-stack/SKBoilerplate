
import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/shared/paginated.dart';

abstract interface class BrandsRepository {
  Future<Paginated<Brand>> brands({int? page, int? limit});
}