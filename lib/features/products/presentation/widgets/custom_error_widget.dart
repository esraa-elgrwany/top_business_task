import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off, size: 48.w, color: Colors.grey[400]),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              message,
              style: TextStyle(color: Colors.red, fontSize: 13.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 14.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A237E),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
            ),
            onPressed: onRetry,
            child: Text('Retry Connection', style: TextStyle(color: Colors.white, fontSize: 13.sp)),
          )
        ],
      ),
    );
  }
}