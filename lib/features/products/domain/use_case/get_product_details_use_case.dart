import 'package:dartz/dartz.dart';
import 'package:test_task/core/errors/failures.dart';
import 'package:test_task/features/products/domain/entity/product_details_entity.dart';
import 'package:test_task/features/products/domain/repo/product_repo.dart';

class GetProductDetailsUseCase {
  final ProductRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<Either<Failures, ProductDetailsResponseEntity>> call({required String slug}) {
    return repository.getProductDetails(slug: slug);
  }
}