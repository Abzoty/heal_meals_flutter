import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/ui/widgets/recipe_card.dart';

class DiscoverResultsSection extends StatelessWidget {
  final List<Map<String, dynamic>> recipes;

  const DiscoverResultsSection({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
            child: Text(
              'Results',
              style: TextStyle(
                color: Color.fromARGB(255, 104, 103, 103),
                fontSize: 32.sp,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: 4.h, top: 8.h),
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            final item = recipes[index];
            return Padding(
              padding: EdgeInsets.all(4.w),
              child: RecipeCard(
                id: item['id']!,
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

