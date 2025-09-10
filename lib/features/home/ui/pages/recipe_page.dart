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
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> ingredients = [
      "Onion",
      "Garlic",
      "Tomato",
      "Pepper",
      "Salt",
      "Meat",
      "Oil",
      "Rice",
    ];

    final TimeOfDay prepTime = const TimeOfDay(hour: 0, minute: 15);
    final String description =
        "A quick nutritious recipe that will satisfy your cravings!";
    final int stars = 26;

    final List<Map<String, String>> steps = [
      {
        "image": "assets/images/step1.jpeg",
        "text": "Chop the vegetables into small pieces.",
      },
      {
        "image": "assets/images/step2.jpeg",
        "text": "Heat oil in a pan and add meat balls.",
      },
      {
        "image": "assets/images/step3.jpeg",
        "text": "Add tomato sauce and spices, then cook for 5 minutes.",
      },
      {
        "image": "assets/images/step4.jpeg",
        "text": "Serve hot with vegetables on the side.",
      },
    ];

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
                    "Recipe Title",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Recipe Image
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/food.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Discover More Button
              const DiscoverMoreButton(),
              SizedBox(height: 20.h),

              // Prep Time
              RecipePrepTimeAndStars(prepTime: prepTime, stars: stars),
              SizedBox(height: 10.h),

              // Description
              RecipeDescription(description: description),
              SizedBox(height: 10.h),

              // Ingredients
              Text(
                "Ingredients:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),

              // Ingredients list
              RecipeIngredients(ingredients: ingredients),
              SizedBox(height: 20.h),

              // Steps
              Text(
                "Steps:",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),

              // Steps
              RecipeSteps(steps: steps),
            ],
          ),
        ),
      ),
    );
  }
}
