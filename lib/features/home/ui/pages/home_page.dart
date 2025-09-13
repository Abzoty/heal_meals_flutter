import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_card.dart';
import 'package:heal_meals/features/home/ui/widgets/top_pics.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9EDED),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                          overflow: TextOverflow.ellipsis, // prevent overflow
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Icon(
                        Icons.account_circle,
                        size: 60.r,
                        color: Color(0xFF1B512D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TopPicksSection(),
            SizedBox(height: 20.h),
            for (int i = 0; i < 5; i++)
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h),
                child: RecipeCard(
                  imageUrl: 'assets/images/food.jpg',
                  title: 'Grilled Chicken Salad',
                  description: 'A healthy mix of grilled chicken and fresh veggies.',
                  stars: 14,
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'home')
    );
  }
}

