import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/products/domain/use_case/get_product_details_use_case.dart';
import 'package:test_task/features/products/presentation/manager/get_product_details_cubit/get_product_details_state.dart';


class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  ProductDetailsCubit(this.getProductDetailsUseCase) : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(String slug) async {
    emit(ProductDetailsLoading());

    final result = await getProductDetailsUseCase.call(slug: slug);

    result.fold(
          (failure) => emit(ProductDetailsFailure(failure.errorMsg)),
          (entity) {
        if (entity.data?.productDetails != null) {
          emit(ProductDetailsSuccess(entity.data!.productDetails!));
        } else {
          emit(ProductDetailsFailure("Target product is missing or unavailable."));
        }
      },
    );
  }
}
