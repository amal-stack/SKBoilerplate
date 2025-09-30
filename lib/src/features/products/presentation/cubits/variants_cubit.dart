import 'package:boilerplate/src/features/products/domain/product_variant.dart';
import 'package:boilerplate/src/features/products/domain/repositories/products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class ProductVariantsState {
  const ProductVariantsState();
}

class ProductVariantsInitial extends ProductVariantsState {
  const ProductVariantsInitial();
}

class ProductVariantsFetched extends ProductVariantsState {
  const ProductVariantsFetched(this.variants);

  final List<ProductVariant> variants;
}

class ProductVariantsError extends ProductVariantsState {
  const ProductVariantsError(this.message);

  final String message;
}

class ProductVariantsCubit extends Cubit<ProductVariantsState> {
  ProductVariantsCubit(this._repository)
    : super(const ProductVariantsInitial());

  final ProductsRepository _repository;

  Future<void> fetchVariants({
    required String modelId,
    int? page,
    int? limit,
  }) async {
    try {
      final result = await _repository.variants(modelId: modelId);
      emit(ProductVariantsFetched(result));
    } catch (e) {
      emit(ProductVariantsError(e.toString()));
    }
  }
}
