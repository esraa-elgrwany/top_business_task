import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductMetaInfo extends StatelessWidget {
  final String name;
  final int? priceAfterDiscount;
  final int? priceBeforeDiscount;
  final double? discount;
  final bool hasDiscount;
  final num? rate;
  final bool isOutOfStock;
  final int? stockCount;

  const ProductMetaInfo({
    super.key,
    required this.name,
    required this.priceAfterDiscount,
    required this.priceBeforeDiscount,
    required this.discount,
    required this.hasDiscount,
    required this.rate,
    required this.isOutOfStock,
    required this.stockCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              ' ⭐ ${rate ?? 0.0}',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp,color: Colors.grey),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              '${priceAfterDiscount ?? 0} EGP',
              style: TextStyle(fontSize: 16.sp, color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10.w),
            if (hasDiscount) ...[
              Text(
                '${priceBeforeDiscount ?? 0} EGP',
                style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 13.sp),
              ),
            ]
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              isOutOfStock ? "Out of Stock" : "Available ($stockCount)",
              style: TextStyle(
                color: isOutOfStock ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}