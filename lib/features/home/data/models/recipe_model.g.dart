// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
  recipeId: json['recipeId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  prepTime: json['prepTime'] as String,
  stars: (json['stars'] as num).toInt(),
  steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
  recipeIngredients: (json['recipeIngredients'] as List<dynamic>)
      .map((e) => RecipeIngredientModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'recipeId': instance.recipeId,
      'title': instance.title,
      'description': instance.description,
      'prepTime': instance.prepTime,
      'stars': instance.stars,
      'steps': instance.steps,
      'recipeIngredients': instance.recipeIngredients,
    };

RecipeIngredientModel _$RecipeIngredientModelFromJson(
  Map<String, dynamic> json,
) => RecipeIngredientModel(
  recipeIngredientId: json['recipeIngredientId'] as String,
  recipeId: json['recipeId'] as String,
  ingredientId: json['ingredientId'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  unit: json['unit'] as String,
);

Map<String, dynamic> _$RecipeIngredientModelToJson(
  RecipeIngredientModel instance,
) => <String, dynamic>{
  'recipeIngredientId': instance.recipeIngredientId,
  'recipeId': instance.recipeId,
  'ingredientId': instance.ingredientId,
  'quantity': instance.quantity,
  'unit': instance.unit,
};
