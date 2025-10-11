import 'package:boilerplate/src/features/brands/data/models/response.dart';

abstract interface class BrandsDataSource {
  Future<BrandsResponse> brands({int? page, int? limit, String? search});
}
