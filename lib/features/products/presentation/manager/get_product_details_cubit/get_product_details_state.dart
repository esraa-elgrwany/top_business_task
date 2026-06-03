import 'package:test_task/features/products/domain/entity/product_details_entity.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}
class ProductDetailsLoading extends ProductDetailsState {}
class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsItemEntity product;
  ProductDetailsSuccess(this.product);
}
class ProductDetailsFailure extends ProductDetailsState {
  final String message;
  ProductDetailsFailure(this.message);
}
