import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const DiscoverSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.only(right: 8.w, left: 30.w),
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: TextField(
          controller: controller,
          textInputAction:
              TextInputAction.search, // ✅ makes keyboard show "search"
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: onSearch, // ✅ search icon
            ),
            border: InputBorder.none,
            hintText: 'Search recipes',
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 14.h),
          ),
          onSubmitted: (_) => onSearch(), // ✅ keyboard search button
        ),
      ),
    );
  }
}
