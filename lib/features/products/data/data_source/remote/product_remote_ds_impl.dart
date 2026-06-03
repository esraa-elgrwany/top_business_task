import 'package:dartz/dartz.dart';
import 'package:test_task/core/api/api-manager.dart';
import 'package:test_task/core/api/end_points.dart';
import 'package:test_task/core/errors/failures.dart';
import 'package:test_task/features/products/data/data_source/remote/product_remote_ds.dart';
import 'package:test_task/features/products/data/models/product_details_model.dart';
import 'package:test_task/features/products/data/models/product_list_model.dart';


class ProductRemoteDsImpl implements ProductRemoteDs {
  final ApiManager apiManager;

  ProductRemoteDsImpl(this.apiManager);

  @override
  Future<Either<Failures, ProductListModel>> getProducts({
    required int perPage,
    required int page,
    String? name,
  }) async {
    try {
      final response = await apiManager.getData(
        EndPoints.getProducts,
        queryParameters: {
          'products_per_page': perPage,
          'page_number': page,
          if (name != null && name.isNotEmpty) 'name': name,
        },
      );

      return Right(ProductListModel.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, ProductDetailsResponseModel>> getProductDetails({
    required String slug,
  }) async {
    try {
      final response = await apiManager.getData(
        EndPoints.getProductDetails,
        queryParameters: {'slug': slug},
      );
      return Right(ProductDetailsResponseModel.fromJson(response.data));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}