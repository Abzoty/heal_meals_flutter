import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/discover_more_button.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_description.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_ingredients.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_prep_time_and_stars.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_steps.dart';

class RecipePage extends StatelessWidget {
  static const routeName = '/recipe';
  

  const RecipePage({super.key, required String recipeId});

  @override
  Widget build(BuildContext context) {
    // ---------- Built-in data ----------
    const String recipeTitle = 'Classic Pasta';
    const String recipeDescription =
        'A simple, hearty pasta recipe with a rich tomato sauce and fresh herbs.';
    final TimeOfDay recipePrepTime = const TimeOfDay(hour: 0, minute: 30);
    const int recipeStars = 4;

    final List<String> recipeIngredients = [
      '200 g pasta',
      '2 cups tomato sauce',
      '1 tbsp olive oil',
      '2 cloves garlic',
      'Salt & pepper to taste',
      'Fresh basil leaves',
    ];

    final List<String> recipeSteps = [
      'Boil pasta according to package instructions.',
      'Heat olive oil and sauté garlic until fragrant.',
      'Add tomato sauce, salt, and pepper. Simmer for 10 minutes.',
      'Combine pasta with sauce and top with fresh basil.',
    ];
    // -----------------------------------

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(currentPage: 'recipe'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 24.sp),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Text(
                    recipeTitle,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Recipe Image (placeholder)
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/food.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              const DiscoverMoreButton(),
              SizedBox(height: 20.h),

              RecipePrepTimeAndStars(
                prepTime: recipePrepTime,
                stars: recipeStars,
              ),
              SizedBox(height: 10.h),

              RecipeDescription(description: recipeDescription),
              SizedBox(height: 10.h),

              Text(
                "Ingredients:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),

              RecipeIngredients(ingredients: recipeIngredients),
              SizedBox(height: 20.h),

              Text(
                "Steps:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),

              RecipeSteps(steps: recipeSteps),
            ],
          ),
        ),
      ),
    );
  }
}
