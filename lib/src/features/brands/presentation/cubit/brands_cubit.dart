import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/features/brands/domain/repositories/brands_repository.dart';
import 'package:boilerplate/src/shared/paginated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

@immutable
sealed class BrandsState {
  const BrandsState();
}

class BrandsInitial extends BrandsState {
  const BrandsInitial();
}

class BrandsLoading extends BrandsState {
  const BrandsLoading();
}

class BrandsFetched extends BrandsState {
  const BrandsFetched(this.brands);

  final Paginated<Brand> brands;
}

class BrandsError extends BrandsState {
  const BrandsError(this.message);

  final String message;
}

class BrandsCubit extends Cubit<BrandsState> {
  BrandsCubit(this._repository) : super(const BrandsInitial());

  final BrandsRepository _repository;

  Future<void> fetchBrands({int? page, int? limit}) async {
    emit(const BrandsLoading());
    try {
      final result = await _repository.brands(page: page, limit: limit);
      emit(BrandsFetched(result));
    } catch (e) {
      emit(BrandsError(e.toString()));
    }
  }
}
