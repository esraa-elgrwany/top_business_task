import 'package:dartz/dartz.dart';
import 'package:test_task/features/products/domain/entity/product_details_entity.dart';
import '../../../../core/errors/failures.dart';
import '../entity/product_list_entity.dart';

abstract class ProductRepository {

  //get products
  Future<Either<Failures, ProductListEntity>> getProducts({
    required int perPage,
    required int page,
    String? name,
  });

  //get product details
  Future<Either<Failures, ProductDetailsResponseEntity>> getProductDetails({
    required String slug,
  });
}
