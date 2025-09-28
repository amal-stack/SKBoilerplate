import 'package:boilerplate/src/features/dashboard/domain/entities/brand.dart';
import 'package:boilerplate/src/features/dashboard/domain/repositories/brands_repository.dart';
import 'package:boilerplate/src/shared/paginated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class BrandsState {}

class BrandsInitial extends BrandsState {}

class BrandsLoading extends BrandsState {}

class BrandsFetched extends BrandsState {
  BrandsFetched(this.brands);

  final Paginated<Brand> brands;
}

class BrandsError extends BrandsState {
  BrandsError(this.message);

  final String message;
}

class BrandsCubit extends Cubit<BrandsState> {
  BrandsCubit(this._repository) : super(BrandsInitial());

  final BrandsRepository _repository;

  Future<void> fetchBrands({int? page, int? limit}) async {
    emit(BrandsLoading());
    try {
      final result = await _repository.brands(page: page, limit: limit);
      emit(BrandsFetched(result));
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }
}
