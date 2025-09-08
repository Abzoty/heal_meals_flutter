import 'package:flutter/material.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/discover_more_button.dart';

class RecipePage extends StatelessWidget {
  static const routeName = '/recipe';
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy ingredients list
    final List<String> ingredients = [
      "Onion",
      "Garlic",
      "Tomato",
      "Pepper",
      "Salt",
      "Meat",
      "Oil",
      "Rice",
    ];

    // Dummy steps list
    final List<Map<String, String>> steps = [
      {
        "image": "assets/images/step1.jpeg",
        "text": "Chop the vegetables into small pieces.",
      },
      {
        "image": "assets/images/step2.jpeg",
        "text": "Heat oil in a pan and add meat balls.",
      },
      {
        "image": "assets/images/step3.jpeg",
        "text": "Add tomato sauce and spices, then cook for 5 minutes.",
      },
      {
        "image": "assets/images/step4.jpeg",
        "text": "Serve hot with vegetables on the side.",
      },
    ];

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(currentPage: 'recipe'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Title & Back Button
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const Text(
                    "Recipe Title",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Recipe Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/food.jpg",
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Button to navigate
              DiscoverMoreButton(),
              const SizedBox(height: 20),

              // Ingredients Section
              const Text(
                "Ingredients:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ingredients.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.5,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFF2C7B46),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      ingredients[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Steps Section
              const Text(
                "Steps:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              Column(
                children: steps.asMap().entries.map((entry) {
                  int index = entry.key + 1;
                  var step = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF1B512D),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          step["image"]!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Step $index",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(step["text"]!, style: const TextStyle(color: Colors.white),),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}