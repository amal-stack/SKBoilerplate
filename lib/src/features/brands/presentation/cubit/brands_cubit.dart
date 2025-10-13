import 'dart:async';

import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/features/brands/domain/repositories/brands_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:boilerplate/src/shared/paginated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BrandsState = ViewState<Paginated<Brand>>;
typedef BrandsInitial = ViewInitial<Paginated<Brand>>;
typedef BrandsFetched = ViewSuccess<Paginated<Brand>>;
typedef BrandsError = ViewError<Paginated<Brand>>;

class BrandsCubit extends Cubit<BrandsState>
    with DebounceCubitMixin<BrandsState>, RetryCubitMixin<Paginated<Brand>> {
  BrandsCubit(this._repository) : super(const BrandsInitial());

  static const Duration debounceDuration = Duration(milliseconds: 500);

  final BrandsRepository _repository;

  Future<void> fetchBrands({int? page, int? limit}) =>
      withRetry(() => _repository.allBrands(page: page, limit: limit));

  Future<void> searchBrands(String query, {int? page, int? limit}) =>
      withRetry(() => _repository.search(query, page: page, limit: limit));

  void searchBrandsWithDebounce(String query, {int? page, int? limit}) {
    withDebouncing(debounceDuration, () {
      searchBrands(query, page: page, limit: limit);
    });
  }
}
