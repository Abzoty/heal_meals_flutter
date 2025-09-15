import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/data/models/recipe_model.dart';
import 'package:heal_meals/features/home/logic/Repositories/recipe_repository.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/discover_more_button.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_description.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_ingredients.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_prep_time_and_stars.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_steps.dart';

class RecipePage extends StatelessWidget {
  static const routeName = '/recipe';
  final String recipeId; // 👈 accept ID

  const RecipePage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    final RecipeRepository recipeRepository = RecipeRepository();

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(currentPage: 'recipe'),
      body: SafeArea(
        child: FutureBuilder<Recipe>(
          future: recipeRepository.getSpecificRecipe(recipeId), // 👈 use ID
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Center(child: Text("No recipe found"));
            }

            final recipe = snapshot.data!;

            return SingleChildScrollView(
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
                        recipe.title,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // Recipe Image (placeholder since your API has no image yet)
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
                    prepTime: TimeOfDay(
                      hour: recipe.prepTime.hour,
                      minute: recipe.prepTime.minute,
                    ),
                    stars: recipe.stars,
                  ),
                  SizedBox(height: 10.h),

                  RecipeDescription(description: recipe.description),
                  SizedBox(height: 10.h),

                  Text(
                    "Ingredients:",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  RecipeIngredients(ingredients: recipe.recipeIngredients),
                  SizedBox(height: 20.h),

                  Text(
                    "Steps:",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  RecipeSteps(
                    steps: recipe.steps
                        .map(
                          (e) => {
                            "image": "assets/images/step1.jpeg",
                            "text": e,
                          },
                        )
                        .toList(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
