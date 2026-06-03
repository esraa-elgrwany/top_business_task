import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:test_task/config/routes/routes.dart';
import 'package:test_task/features/products/domain/entity/product_details_entity.dart';


class RelatedProductsList extends StatelessWidget {
  final List<RelatedProductEntity>? relatedProducts;

  const RelatedProductsList({super.key, this.relatedProducts});

  @override
  Widget build(BuildContext context) {
    if (relatedProducts == null || relatedProducts!.isEmpty)
      return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 32.h, thickness: 0.8),
        Text(
          'Related Products',
          style: TextStyle(fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 170.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: relatedProducts!.length,
            itemBuilder: (context, index) {
              final related = relatedProducts![index];
              return GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(
                      context,
                      RoutesName.productDetailsScreen,
                      arguments: related.slug ?? '',
                    ),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  elevation: 1.5,
                  child: Container(
                      width: 120.w,
                      margin: EdgeInsets.only(right: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(4.w),
                                width: double.infinity,
                                child: CachedNetworkImage(
                                  imageUrl: related.thumbnail ?? '',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  related.name ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: Colors.black),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Text(
                                      '${related.priceAfterDiscount ?? 0} EGP',
                                      style: TextStyle(color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8.sp),
                                    ),
                                    if (related.hasDiscount) ...[
                                      Spacer(),
                                      Text(
                                        '${related.priceBeforeDiscount ?? 0} EGP',
                                        style: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                          fontSize: 6.sp,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      related.isOutOfStock
                                          ? 'Sold Out'
                                          : 'In Stock',
                                      style: TextStyle(
                                        color: related.isOutOfStock
                                            ? Colors.red
                                            : Colors.green,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (related.isOutOfStock!)
                                      Container(
                                        padding: EdgeInsets.all(4.w),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF1A237E)),
                                        child: Icon(
                                            Icons.add, color: Colors.white,
                                            size: 14.w),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                                ),
                ));
            },
          ),
        ),
      ],
    );
  }
}