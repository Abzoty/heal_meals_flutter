import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/ui/pages/recipe_page.dart';

class TopPicksSection extends StatelessWidget {
  // Dummy list of images and titles
  final List<Map<String, dynamic>> topPicks = [
    {
      "image": "assets/images/food.jpg",
      "title": "Chicken soup",
      "stars": 13,
      "id": "1",
    },
    {
      "image": "assets/images/food.jpg",
      "title": "Meat balls",
      "stars": 9,
      "id": "1",
    },
    {
      "image": "assets/images/food.jpg",
      "title": "Pasta",
      "stars": 33,
      "id": "1",
    },
  ];

  TopPicksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Top Picks",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Horizontal List of Cards
        SizedBox(
          height: 180.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topPicks.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipePage(
                        recipeId: topPicks[index]["id"],
                      ), // 👈 pass id
                    ),
                  );
                },
                child: Container(
                  width: 300.w,
                  margin: EdgeInsets.only(
                    left: 16.w,
                    right: index == topPicks.length - 1 ? 16.w : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: AssetImage(topPicks[index]["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Gradient overlay for text visibility
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                const Color.fromARGB(88, 0, 0, 0),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Recipe title text and stars
                      Positioned(
                        left: 12.w,
                        bottom: 12.h,
                        child: Row(
                          children: [
                            Text(
                              topPicks[index]["title"]!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(Icons.star, color: Colors.yellow, size: 16.r),
                            SizedBox(width: 2.w),
                            Text(
                              topPicks[index]["stars"].toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
