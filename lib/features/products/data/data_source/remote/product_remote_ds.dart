import 'package:dartz/dartz.dart';
import 'package:test_task/features/products/data/models/product_list_model.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entity/product_details_entity.dart';

abstract class ProductRemoteDs{
  Future<Either<Failures,ProductListModel>> getProducts({required int perPage,
    required int page,
    String? name,});

  Future<Either<Failures, ProductDetailsResponseEntity>> getProductDetails({
    required String slug,
  });
}
