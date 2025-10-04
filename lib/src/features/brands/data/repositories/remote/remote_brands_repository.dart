import 'package:boilerplate/src/features/brands/data/data_sources/brands_data_source.dart';
import 'package:boilerplate/src/features/brands/data/models/response.dart';
import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/features/brands/domain/repositories/brands_repository.dart';
import 'package:boilerplate/src/shared/paginated.dart';

class RemoteBrandsRepository implements BrandsRepository {
  const RemoteBrandsRepository(this.dataSource);

  final BrandsDataSource dataSource;

  @override
  Future<Paginated<Brand>> brands({int? page, int? limit}) async {
    final BrandsResponse response = await dataSource.brands(
      page: page,
      limit: limit,
    );

    return response.toPaginated();
  }
}
