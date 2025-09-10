import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";

class AddedItemTile extends StatelessWidget {
  final String name;
  final VoidCallback onRemove;
  final Color accentGreen;

  const AddedItemTile({
    super.key,
    required this.name,
    required this.onRemove,
    required this.accentGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: accentGreen,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, top: 4.h, bottom: 4.h),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: onRemove,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: Icon(Icons.delete, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
