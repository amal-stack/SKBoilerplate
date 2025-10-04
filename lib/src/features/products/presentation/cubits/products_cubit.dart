import 'package:boilerplate/src/features/products/domain/product.dart';
import 'package:boilerplate/src/features/products/domain/repositories/products_repository.dart';
import 'package:boilerplate/src/shared/paginated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsFetched extends ProductsState {
  ProductsFetched(this.products);

  final Paginated<Product> products;
}

class ProductsError extends ProductsState {
  ProductsError(this.message);

  final String message;
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._repository) : super(ProductsInitial());

  final ProductsRepository _repository;

  Future<void> fetchProducts({
    required String brandId,
    int? page,
    int? limit,
  }) async {
    emit(ProductsLoading());
    try {
      final result = await _repository.products(
        brandId: brandId,
        page: page,
        limit: limit,
      );
      emit(ProductsFetched(result));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
