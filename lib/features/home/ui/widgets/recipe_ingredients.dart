import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RecipeIngredients extends StatelessWidget {
  const RecipeIngredients({super.key, required List<dynamic> ingredients});
  //const RecipeIngredients({super.key, required this.ingredients});
  //final List<RecipeIngredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      //itemCount: ingredients.length,
      itemCount: 5,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
        childAspectRatio: 1.8, // Reduced from 2.5 to give more height
      ),
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2C7B46),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                //'${ingredients[index].quantity.toInt()} ${ingredients[index].unit}',
                '${index + 1}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                //'of ${ingredients[index].name}',
                'of ${index + 1}',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
