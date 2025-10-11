import 'package:boilerplate/src/features/brands/data/data_sources/brands_data_source.dart';
import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/features/brands/domain/repositories/brands_repository.dart';
import 'package:boilerplate/src/shared/paginated.dart';

class RemoteBrandsRepository implements BrandsRepository {
  const RemoteBrandsRepository(this.dataSource);

  final BrandsDataSource dataSource;

  @override
  Future<Paginated<Brand>> allBrands({int? page, int? limit}) =>
      _brands(page: page, limit: limit);

  @override
  Future<Paginated<Brand>> search(String query, {int? page, int? limit}) =>
      _brands(search: query, page: page, limit: limit);

  Future<Paginated<Brand>> _brands({int? page, int? limit, String? search}) =>
      dataSource
          .brands(page: page, limit: limit, search: search)
          .then((response) => response.toPaginated());
}
