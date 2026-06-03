import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductImageGallery extends StatelessWidget {
  final List<String>? images;
  final bool hasDiscount;
  final double? discount;
  final bool inWishlist;

  const ProductImageGallery({
    super.key,
    required this.images,
    required this.hasDiscount,
    required this.discount,
    required this.inWishlist,
  });

  @override
  Widget build(BuildContext context) {
    if (images == null || images!.isEmpty) return const SizedBox.shrink();

    return Stack(
      children: [
        SizedBox(
          height: 220.h,
          child: PageView.builder(
            itemCount: images!.length,
            itemBuilder: (context, index) => CachedNetworkImage(
              imageUrl: images![index],
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) => Icon(Icons.broken_image, size: 40.w, color: Colors.grey),
            ),
          ),
        ),

        if (hasDiscount && discount != null && discount! > 0)
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1A237E),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                '-${discount!.toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        Positioned(
          top: 4.h,
          right: 4.w,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
                inWishlist ? Icons.favorite : Icons.favorite_border,
                color: inWishlist ? Colors.red : Colors.grey.shade400,
                size: 22.w,
              ),

          ),
        ),
      ],
    );
  }
}