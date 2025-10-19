import 'package:boilerplate/src/features/products/domain/product_variant.dart';
import 'package:boilerplate/src/features/products/domain/repositories/products_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:flutter/foundation.dart';
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

class PricingCubit extends Cubit<ViewState<DevicePricing>> {
  PricingCubit(this._repository) : super(const ViewState.initial());

  final ProductsRepository _repository;

  Map<String, DevicePricing> pricingCache = {};

  Future<void> fetchPricing({required String variantId}) async {
    emit(const ViewState.loading());
    try {
      if (pricingCache.containsKey(variantId)) {
        debugPrint('Fetching pricing from cache for $variantId');
        emit(ViewState.success(pricingCache[variantId]!));
        return;
      }
      final List<DevicePricing> result = await _repository.pricing(
        variantId: variantId,
      );
      if (result.isNotEmpty) {
        pricingCache[variantId] = result.first;
        emit(ViewState.success(result.first));
        return;
      }
      emit(const ViewState.error('No pricing data available'));
    } catch (e) {
      emit(ViewState.error(e.toString()));
    }
  }
}
