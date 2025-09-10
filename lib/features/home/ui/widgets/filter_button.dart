import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiscoverFilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DiscoverFilterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.filter_list, color: Colors.white, size: 20.sp),
        label: Text(
          'Filters',
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          backgroundColor: const Color(0xFF1B512D),
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        ),
      ),
    );
  }
}
