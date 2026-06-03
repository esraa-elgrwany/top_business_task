import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search products..',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 12.sp,color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.w),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r),borderSide: BorderSide(
              color: Colors.grey
          )),
          enabledBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(12.r),borderSide: BorderSide(
            color: Colors.grey
          )) ,
          focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(12.r),borderSide: BorderSide(
              color: Colors.grey
          )) ,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        onChanged: onChanged,
      ),
    );
  }
}