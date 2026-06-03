import 'package:dartz/dartz.dart';
import 'package:test_task/core/errors/failures.dart';
import 'package:test_task/features/products/domain/entity/product_list_entity.dart';
import 'package:test_task/features/products/domain/repo/product_repo.dart';


class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failures, ProductListEntity>> call({
    required int perPage,
    required int page,
    String? name,
  }) {
    return repository.getProducts(perPage: perPage, page: page, name: name);
  }
}