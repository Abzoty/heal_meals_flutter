import 'package:flutter/material.dart';
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
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.bookmark, size: 60, color: Color(0XFF1B512D)),
                  SizedBox(width: 8),
                  Text(
                    'Favorites',
                    style: TextStyle(
                      fontSize: 32,
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
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 8.0,
                  ),
                  child: RecipeCard(
                    title: 'Recipe $index',
                    description: 'This is a description for recipe $index',
                    imageUrl: 'assets/images/food.jpg',
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
