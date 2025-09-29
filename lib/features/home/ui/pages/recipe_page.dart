import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/logic/cubit/recipe_cubit.dart';
import 'package:heal_meals/features/home/ui/widgets/book_mark_button.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/discover_more_button.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_description.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_ingredients.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_prep_time_and_stars.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_steps.dart';
import 'package:heal_meals/features/home/ui/widgets/review_button.dart';

class RecipePage extends StatelessWidget {
  static const routeName = '/recipe';
  final String recipeId;

  const RecipePage({super.key, required this.recipeId,});

  @override
  Widget build(BuildContext context) {
    // trigger fetch
    context.read<RecipeCubit>().getRecipeById(recipeId);

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(currentPage: 'recipe'),
      body: SafeArea(
        child: BlocBuilder<RecipeCubit, RecipeState>(
          buildWhen: (_, curr) =>
              curr is RecipeLoading ||
              curr is RecipeLoaded ||
              curr is RecipeError,
          builder: (context, state) {
            if (state is RecipeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecipeLoaded) {
              final recipe = state.recipes; // from API

              return SingleChildScrollView(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, size: 24.sp),
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, '/home'),
                        ),
                        Expanded(
                          child: Text(
                            recipe.title ?? 'No Title',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        BookmarkButton(recipeId: recipe.recipeId ?? ''),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // Recipe Image
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
                      prepTime: recipe.prepTime ?? '0:00',
                      stars: recipe.stars ?? 0,
                    ),
                    SizedBox(height: 10.h),

                    RecipeDescription(
                      description:
                          recipe.description ?? 'No description available',
                    ),
                    SizedBox(height: 10.h),

                    Text(
                      "Ingredients:",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    RecipeIngredients(
                      ingredients: recipe.recipeIngredients ?? [],
                    ),
                    SizedBox(height: 20.h),

                    Text(
                      "Steps:",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    RecipeSteps(steps: recipe.steps ?? []),

                    SizedBox(height: 8.h),

                    ReviewButton(recipeId: recipeId,),
                  ],
                ),
              );
            } else if (state is RecipeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    ElevatedButton(
                      onPressed: () {
                        context.read<RecipeCubit>().getRecipeById(recipeId);
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
