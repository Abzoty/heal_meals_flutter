import 'package:flutter/material.dart';
import 'package:heal_meals/core/routing/routes.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final int stars;


  const RecipeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.recipe);
      },
      child: Container(
        width: 370, // keep width fixed if you want, but remove height
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1B512D), // green background
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start, // align top for multi-line text
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imageUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
