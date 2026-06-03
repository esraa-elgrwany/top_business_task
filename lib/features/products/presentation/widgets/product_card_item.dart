import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_task/features/products/presentation/manager/get_product_cubit/product_list_cubit.dart';
import '../../data/models/product_list_model.dart';

class ProductCardItem extends StatelessWidget {
  final ProductsModel product;
  final VoidCallback onTap;

  const ProductCardItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = (product.productStockCount ?? 0) <= 0;
    final bool hasDiscount = (product.discount ?? 0.0) > 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        elevation: 1.5,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.all(8.w),
                      child: CachedNetworkImage(
                        imageUrl: product.thumbnail ?? '',
                        fit: BoxFit.contain,
                        errorWidget: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12.sp, color: Colors.black),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Text(
                            '${product.priceAfterDiscount ?? 0} EGP',
                            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 10.sp),
                          ),
                          if (hasDiscount) ...[
                            const Spacer(),
                            Text(
                              '${product.priceBeforeDiscount ?? 0} EGP',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 8.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ]
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isOutOfStock ? 'Sold Out' : 'In Stock',
                            style: TextStyle(
                              color: isOutOfStock ? Colors.red : Colors.green,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (!isOutOfStock)
                            Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1A237E)),
                              child: Icon(Icons.add, color: Colors.white, size: 14.w),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (hasDiscount)
              Positioned(
                top: 4.h, left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                  decoration: BoxDecoration(color: const Color(0xFF1A237E), borderRadius: BorderRadius.circular(4.r)),
                  child: Text(
                    '-${product.discount?.toStringAsFixed(0)}%',
                    style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            Positioned(
              top: 2.h, right: 2.w,
              child: IconButton(
                icon: Icon(
                  product.inWishlist == true ? Icons.favorite : Icons.favorite_border,
                  // Changed from Colors.green to red to stay uniform across app screens
                  color: product.inWishlist == true ? Colors.red : Colors.grey[600],
                  size: 22.w,
                ),
                onPressed: () {
                  // FIXED: Triggers the background state mutation loop instantly on touch event
                  context.read<ProductsListCubit>().toggleProductFavorite(product.slug ?? '');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}