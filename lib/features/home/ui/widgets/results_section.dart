import 'package:flutter/material.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_card.dart';

class DiscoverResultsSection extends StatelessWidget {
  final List<Map<String, String>> recipes;

  const DiscoverResultsSection({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8),
            child: const Text(
              'Results',
              style: TextStyle(
                color: Color.fromARGB(255, 104, 103, 103),
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 4, top: 8),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final item = recipes[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: RecipeCard(
                imageUrl: item['imageUrl'] ?? '',
                title: item['title']!,
                description: item['description']!,
                stars: item['stars'] != null ? int.parse(item['stars']!) : 0,
              ),
            );
          },
        ),
      ],
    );
  }
}
