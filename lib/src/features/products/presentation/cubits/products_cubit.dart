import 'package:boilerplate/src/features/products/domain/product.dart';
import 'package:boilerplate/src/features/products/domain/repositories/products_repository.dart';
import 'package:boilerplate/src/shared/cubits/state.dart';
import 'package:boilerplate/src/shared/paginated.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ProductsState = ViewState<Paginated<Product>>;
typedef ProductsInitial = ViewInitial<Paginated<Product>>;
typedef ProductsFetched = ViewSuccess<Paginated<Product>>;
typedef ProductsError = ViewError<Paginated<Product>>;


class ProductsCubit extends Cubit<ProductsState> with DebounceCubitMixin<ProductsState> {
  ProductsCubit(this._repository) : super(ProductsInitial());

  static const Duration debounceDuration = Duration(milliseconds: 500);

  final ProductsRepository _repository;


  Future<void> fetchProducts({
    required String brandId,
    int? page,
    int? limit,
  }) => _performFetch(
    () => _repository.allProducts(brandId: brandId, page: page, limit: limit),
  );

  Future<void> searchProducts(
    String query, {
    required String brandId,
    int? page,
    int? limit,
  }) => _performFetch(
    () => _repository.searchProducts(
      query,
      brandId: brandId,
      page: page,
      limit: limit,
    ),
  );

  void searchProductsWithDebounce(
    String query, {
    required String brandId,
    int? page,
    int? limit,
  }) {
    withDebouncing(debounceDuration, () {
      searchProducts(
        query,
        brandId: brandId,
        page: page,
        limit: limit,
      );
    });
  }

  Future<void> _performFetch(
    Future<Paginated<Product>> Function() function,
  ) async {
    emit(ProductsInitial());
    try {
      final result = await function();
      emit(ProductsFetched(result));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
