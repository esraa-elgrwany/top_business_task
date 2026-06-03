import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/core/helper/wish_list_local_manager.dart';
import 'package:test_task/features/products/data/models/product_list_model.dart';
import 'package:test_task/features/products/domain/entity/product_list_entity.dart';
import 'package:test_task/features/products/domain/use_case/get_product_use_case.dart';
import 'package:test_task/features/products/presentation/manager/get_product_cubit/product_list_state.dart';


class ProductsListCubit extends Cubit<ProductsListState> {
  final GetProductsUseCase getProductsUseCase;
  bool _isFetching = false;

  ProductsListCubit(this.getProductsUseCase) : super(ProductsListState.initial());

  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (_isFetching) return;
    if (state.hasReachedMax && !isRefresh) return;

    _isFetching = true;

    if (isRefresh) {
      emit(state.copyWith(
        status: ProductsListStatus.loading,
        currentPage: 1,
        hasReachedMax: false,
        products: [],
      ));
    } else if (state.status == ProductsListStatus.initial) {
      emit(state.copyWith(status: ProductsListStatus.loading));
    }

    final result = await getProductsUseCase.call(
      perPage: state.searchQuery.isNotEmpty ? 10 : 20,
      page: isRefresh ? 1 : state.currentPage,
      name: state.searchQuery,
    );

    result.fold(
          (failure) {
        emit(state.copyWith(
          status: ProductsListStatus.failure,
          errorMessage: failure.errorMsg,
        ));
        _isFetching = false;
      },
          (entity) {
        final incomingProducts = entity.data?.products ?? [];
        final totalPages = entity.data?.pagination?.lastPage ?? 1;
        final currentPageNum = isRefresh ? 1 : state.currentPage;

        final List<String> localFavorites = WishlistLocalManager.getFavoriteSlugs();

        final List<ProductsEntity> syncedIncoming = incomingProducts.map((item) {
          if (item is ProductsModel) {
            final bool isSavedLocally = localFavorites.contains(item.slug);
            return item.copyWith(inWishlist: isSavedLocally);
          }
          return item;
        }).toList();

        emit(state.copyWith(
          status: ProductsListStatus.success,
          products: isRefresh ? syncedIncoming : [...state.products, ...syncedIncoming],
          currentPage: currentPageNum + 1,
          hasReachedMax: currentPageNum >= totalPages || incomingProducts.isEmpty,
        ));
        _isFetching = false;
      },
    );
  }

  void searchProducts(String query) {
    emit(state.copyWith(searchQuery: query, currentPage: 1, hasReachedMax: false, products: []));
    fetchProducts();
  }

  Future<void> toggleProductFavorite(String slug) async {
    final bool isNowFavorited = await WishlistLocalManager.toggleFavorite(slug);

    final List<ProductsEntity> updatedProductsList = state.products.map((element) {
      if (element.slug == slug) {
        if (element is ProductsModel) {
          return element.copyWith(inWishlist: isNowFavorited);
        }
      }
      return element;
    }).toList();

    emit(state.copyWith(products: updatedProductsList));
  }
}