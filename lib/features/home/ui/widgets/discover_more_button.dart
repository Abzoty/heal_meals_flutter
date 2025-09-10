import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';

class DiscoverMoreButton extends StatelessWidget {
  const DiscoverMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB22B28),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.discover);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Discover More Recipes",
              style: TextStyle(fontSize: 16.sp, color: Colors.white),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.explore, color: Colors.white, size: 22.sp),
          ],
        ),
      ),
    );
  }
}
