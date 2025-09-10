import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_card.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = '/favorites';
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9EDED),
      bottomNavigationBar: const CustomNavBar(currentPage: 'favorites'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark, size: 60.r, color: Color(0xFF1B512D)),
                  SizedBox(width: 8.r),
                  Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                5,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
                  child: RecipeCard(
                    title: 'Recipe $index',
                    description: 'This is a description for recipe $index',
                    imageUrl: 'assets/images/food.jpg',
                    stars: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
