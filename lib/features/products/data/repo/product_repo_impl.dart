import 'package:dartz/dartz.dart';
import 'package:test_task/core/errors/failures.dart';
import 'package:test_task/features/products/data/data_source/remote/product_remote_ds.dart';
import 'package:test_task/features/products/domain/entity/product_details_entity.dart';
import 'package:test_task/features/products/domain/entity/product_list_entity.dart';
import 'package:test_task/features/products/domain/repo/product_repo.dart';


class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDs remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failures, ProductListEntity>> getProducts({
    required int perPage,
    required int page,
    String? name,
  }) async {
    return await remoteDataSource.getProducts(
      perPage: perPage,
      page: page,
      name: name,
    );
  }

  @override
  Future<Either<Failures, ProductDetailsResponseEntity>> getProductDetails({
    required String slug,
  }) async {
    return await remoteDataSource.getProductDetails(slug: slug);
  }
}