import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeIngredients extends StatelessWidget {
  const RecipeIngredients({super.key, required this.ingredients});

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ingredients.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF2C7B46),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            ingredients[index],
            style: TextStyle(color: Colors.white, fontSize: 14.sp),
          ),
        );
      },
    );
  }
}
