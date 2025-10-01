import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Add this package to pubspec.yaml
import 'package:heal_meals/features/home/data/models/recipe_model.dart';

class RecipeIngredients extends StatelessWidget {
  final List<RecipeIngredientModel> ingredients;

  const RecipeIngredients({super.key, required this.ingredients});

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
        childAspectRatio: 1.7,
      ),
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        final quantity = ingredient.quantity?.toInt() ?? 0;
        final unit = ingredient.unit ?? '';
        final name = ingredient.name ?? 'Unknown';

        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2C7B46),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Quantity and unit
              Expanded(
                flex: 2,
                child: AutoSizeText(
                  '$quantity $unit',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  minFontSize: 10,
                ),
              ),

              // Ingredient name with auto-sizing
              Expanded(
                flex: 3,
                child: AutoSizeText(
                  'of $name',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  minFontSize: 8, // Minimum readable size
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
