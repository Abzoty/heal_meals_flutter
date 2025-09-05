import 'package:flutter/material.dart';
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
              height: 120,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 45.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, User!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'What will you have today?',
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0, top: 30.0),
                    child: Icon(Icons.account_circle, size: 60, color: Color(0xFF698238)),
                  ),
                ],
              ),
            ),
            TopPicksSection(),
            SizedBox(height: 20),
            for (int i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: RecipeCard(
                  imageUrl: 'assets/images/food.jpg',
                  title: 'Grilled Chicken Salad',
                  description: 'A healthy mix of grilled chicken and fresh veggies.',
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'home')
    );
  }
}
