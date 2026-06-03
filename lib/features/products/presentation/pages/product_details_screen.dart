import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:test_task/features/products/presentation/manager/get_product_cubit/product_list_cubit.dart';
import 'package:test_task/features/products/presentation/manager/get_product_details_cubit/get_product_details_cubit.dart';
import 'package:test_task/features/products/presentation/manager/get_product_details_cubit/get_product_details_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/features/products/presentation/widgets/related_product_list.dart';
import '../widgets/custom_error_widget.dart';
import '../widgets/product_image_gallery.dart';
import '../widgets/product_meta_info.dart';


class ProductDetailsScreen extends StatefulWidget {
  final String slug;
  const ProductDetailsScreen({super.key, required this.slug});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().fetchProductDetails(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black, size: 22.w),
        elevation: 0.0,
        title: Text(
          'Product Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.sp),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is ProductDetailsFailure) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<ProductDetailsCubit>().fetchProductDetails(widget.slug),
            );
          }

          if (state is ProductDetailsSuccess) {
            final product = state.product;
            final bool hasDiscountFlag = product.hasDiscount == true || (product.discount ?? 0) > 0;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImageGallery(
                    images: product.images,
                    hasDiscount: hasDiscountFlag,
                    discount: product.discount?.toDouble(),
                    inWishlist: product.inWishlist == true,
                  ),
                  SizedBox(height: 18.h),

                  ProductMetaInfo(
                    name: product.name ?? '',
                    priceAfterDiscount: product.priceAfterDiscount,
                    priceBeforeDiscount: product.priceBeforeDiscount,
                    discount: product.discount,
                    hasDiscount: hasDiscountFlag,
                    rate: product.rate,
                    isOutOfStock: product.isOutOfStock,
                    stockCount: product.productStockCount,
                  ),

                  Html(
                    data: product.shortDescription ?? '',
                    style: {"body": Style(fontSize: FontSize(12.sp), margin: Margins.zero, color: Colors.black87)},
                  ),

                  Divider(height: 32.h, thickness: 0.8),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Html(
                    data: product.description ?? '',
                    style: {"body": Style(fontSize: FontSize(13.sp), margin: Margins.zero, color: Colors.grey)},
                  ),

                  RelatedProductsList(relatedProducts: product.relatedProducts),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
