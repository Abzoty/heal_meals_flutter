import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeDescription extends StatelessWidget {
  const RecipeDescription({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(10.w),
      child: Text(description, style: TextStyle(fontSize: 16.sp)),
    );
  }
}
