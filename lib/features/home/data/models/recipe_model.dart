class Recipe {
  final String title;
  final String description;
  final DateTime prepTime;
  final int stars;
  final List<String> steps;
  final List<RecipeIngredient> recipeIngredients;

  Recipe({
    required this.title,
    required this.description,
    required this.prepTime,
    required this.stars,
    required this.steps,
    required this.recipeIngredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      prepTime: DateTime.tryParse(json['prepTime'] ?? '') ?? DateTime.now(),
      stars: json['stars'] ?? 0,
      steps: List<String>.from(json['steps'] ?? []),
      recipeIngredients:
          (json['recipeIngredients'] as List<dynamic>?)
              ?.map((e) => RecipeIngredient.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "prepTime": prepTime.toIso8601String(),
      "stars": stars,
      "steps": steps,
      "recipeIngredients": recipeIngredients.map((e) => e.toJson()).toList(),
    };
  }
}

class RecipeIngredient {
  final String ingredientId;
  final String name;
  final num quantity;
  final String unit;

  RecipeIngredient({
    required this.ingredientId,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      ingredientId: json['ingredient_id'] ?? '',
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      unit: json['unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"ingredient_id": ingredientId, "name": name, "quantity": quantity, "unit": unit};
  }
}
