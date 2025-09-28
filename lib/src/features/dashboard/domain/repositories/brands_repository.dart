
import 'package:boilerplate/src/features/dashboard/domain/entities/brand.dart';
import 'package:boilerplate/src/shared/paginated.dart';

abstract interface class BrandsRepository {
  Future<Paginated<Brand>> brands({int? page, int? limit});
}