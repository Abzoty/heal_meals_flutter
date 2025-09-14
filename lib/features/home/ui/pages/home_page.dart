import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/logic/Repositories/recipe_repository.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_card.dart';
import 'package:heal_meals/features/home/ui/widgets/top_pics.dart';
import 'package:heal_meals/features/home/data/models/recipe_model.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeRepository recipeRepo = RecipeRepository();

    return Scaffold(
      backgroundColor: const Color(0xFFF9EDED),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 👤 Header
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 45.h,
                  bottom: 8.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, User!',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'What will you have today?',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Icon(
                        Icons.account_circle,
                        size: 60.r,
                        color: const Color(0xFF1B512D),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🍽️ Top Picks Section
            TopPicksSection(),

            SizedBox(height: 20.h),

            // 📡 Fetch recipes dynamically
            FutureBuilder<List<Recipe>>(
              future: recipeRepo.getAllRecipes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("No recipes found.");
                }

                final recipes = snapshot.data!;
                return Column(
                  children: recipes.map((recipe) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      child: RecipeCard(
                        id: recipe.recipeId,
                        imageUrl:
                            'assets/images/food.jpg', // 🔹 Replace if API returns image
                        title: recipe.title,
                        description: recipe.description,
                        stars: recipe.stars,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'home'),
    );
  }
}
