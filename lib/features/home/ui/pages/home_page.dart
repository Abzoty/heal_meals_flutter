import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/auth/data/models/user_profile_model.dart';
import 'package:heal_meals/features/home/logic/cubit/recipe_cubit.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_card.dart';
import 'package:heal_meals/features/home/ui/widgets/top_pics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  Future<String> _getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return '';
    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    final user = UserProfileModel.fromJson(userMap);
    return user.name;
  }

  @override
  Widget build(BuildContext context) {
    // Trigger fetching of recipes when page loads
    final recipeCubit = context.read<RecipeCubit>();
    recipeCubit.getTopPicks();
    recipeCubit.getAllRecipes();

    return Scaffold(
      backgroundColor: const Color(0xFFF9EDED),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  top: 45.h,
                  bottom: 8.h,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/heal_meals_logo.png',
                      width: 80.w,
                      height: 80.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String>(
                            future: _getUserName(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text(
                                  'Hello...',
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return Text(
                                'Hello, ${snapshot.data}!',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
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
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.notifications,
                          );
                        },
                        icon: const Icon(Icons.notifications_outlined),
                        color: Colors.black,
                        iconSize: 45.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Top Picks
            BlocBuilder<RecipeCubit, RecipeState>(
              buildWhen: (prev, curr) =>
                  curr is RecipeLoading ||
                  curr is RecipeTopPicsListLoaded ||
                  curr is RecipeError,
              builder: (context, state) {
                if (state is RecipeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RecipeTopPicsListLoaded) {
                  return TopPics(recipes: state.recipes);
                } else if (state is RecipeError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),

            /// All Recipes
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w),
              child: Text(
                "All Recipes",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<RecipeCubit, RecipeState>(
              buildWhen: (prev, curr) =>
                  curr is RecipeLoading ||
                  curr is RecipeGetAllListLoaded ||
                  curr is RecipeError,
              builder: (context, state) {
                if (state is RecipeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is RecipeGetAllListLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = state.recipes[index];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: RecipeCard(
                          id: recipe.recipeId,
                          title: recipe.title,
                          description: recipe.description,
                          stars: recipe.stars,
                        ),
                      );
                    },
                  );
                } else if (state is RecipeError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'home'),
    );
  }
}
