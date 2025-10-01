import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  @JsonKey(name: 'recipe_id')
  final String? recipeId;
  final String? title;
  final String? description;
  final String? prepTime;
  final int? stars;
  final List<String>? steps;
  final List<RecipeIngredientModel>? recipeIngredients;

  RecipeModel({
    this.recipeId,
    this.title,
    this.description,
    this.prepTime,
    this.stars,
    this.steps,
    this.recipeIngredients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}

@JsonSerializable()
class RecipeIngredientModel {
  @JsonKey(name: 'recipe_ingredientId')
  final String? recipeIngredientId;
  @JsonKey(name: 'recipe_id')
  final String? recipeId;
  @JsonKey(name: 'ingredient_id')
  final String? ingredientId;
  final String? name;
  final double? quantity;
  final String? unit;

  RecipeIngredientModel({
    this.recipeIngredientId,
    this.recipeId,
    this.ingredientId,
    this.name,
    this.quantity,
    this.unit,
  });

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeIngredientModelToJson(this);
}
