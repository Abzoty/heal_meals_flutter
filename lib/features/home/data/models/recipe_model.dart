import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  final String recipeId;
  final String title;
  final String description;
  final String prepTime;
  final int stars;
  final List<String> steps;
  final List<RecipeIngredientModel> recipeIngredients;

  RecipeModel({
    required this.recipeId,
    required this.title,
    required this.description,
    required this.prepTime,
    required this.stars,
    required this.steps,
    required this.recipeIngredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}

@JsonSerializable()
class RecipeIngredientModel {
  final String recipeIngredientId;
  final String recipeId;
  final String ingredientId;
  final double quantity;
  final String unit;

  RecipeIngredientModel({
    required this.recipeIngredientId,
    required this.recipeId,
    required this.ingredientId,
    required this.quantity,
    required this.unit,
  });

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) => _$RecipeIngredientModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeIngredientModelToJson(this);
}