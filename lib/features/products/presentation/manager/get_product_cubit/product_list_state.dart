import 'package:test_task/features/products/domain/entity/product_list_entity.dart';

enum ProductsListStatus { initial, loading, success, failure }

class ProductsListState {
  final List<ProductsEntity> products;
  final ProductsListStatus status;
  final String errorMessage;
  final int currentPage;
  final bool hasReachedMax;
  final String searchQuery;

  ProductsListState({
    required this.products,
    required this.status,
    required this.errorMessage,
    required this.currentPage,
    required this.hasReachedMax,
    required this.searchQuery,
  });

  factory ProductsListState.initial() {
    return ProductsListState(
      products: [],
      status: ProductsListStatus.initial,
      errorMessage: '',
      currentPage: 1,
      hasReachedMax: false,
      searchQuery: '',
    );
  }

  ProductsListState copyWith({
    List<ProductsEntity>? products,
    ProductsListStatus? status,
    String? errorMessage,
    int? currentPage,
    bool? hasReachedMax,
    String? searchQuery,
  }) {
    return ProductsListState(
      products: products ?? this.products,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
