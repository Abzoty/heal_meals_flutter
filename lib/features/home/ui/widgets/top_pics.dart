import 'package:flutter/material.dart';
import 'package:heal_meals/core/routing/routes.dart';

class TopPicksSection extends StatelessWidget {
  // Dummy list of images and titles
  final List<Map<String, String>> topPicks = [
    {"image": "assets/images/food.jpg", "title": "Chicken soup", "stars": "13"},
    {"image": "assets/images/food.jpg", "title": "Meat balls", "stars": "9"},
    {"image": "assets/images/food.jpg", "title": "Pasta", "stars": "33"},
  ];

  TopPicksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Top Picks",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Horizontal List of Cards
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topPicks.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.recipe);
                },
                child: Container(
                  width: 300,
                  margin: EdgeInsets.only(
                    left: 16,
                    right: index == topPicks.length - 1 ? 16 : 0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
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
                            borderRadius: BorderRadius.circular(16),
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
                        left: 12,
                        bottom: 12,
                        child: Row(
                          children: [
                            Text(
                              topPicks[index]["title"]!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16,
                            ),
                            SizedBox(width: 2),
                            Text(
                              topPicks[index]["stars"]!,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
