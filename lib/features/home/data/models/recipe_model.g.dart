// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
  recipeId: json['recipe_id'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  prepTime: json['prepTime'] as String?,
  stars: (json['stars'] as num?)?.toInt(),
  steps: (json['steps'] as List<dynamic>?)?.map((e) => e as String).toList(),
  recipeIngredients: (json['recipeIngredients'] as List<dynamic>?)
      ?.map((e) => RecipeIngredientModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipeId,
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
  recipeIngredientId: json['recipe_ingredientId'] as String?,
  recipeId: json['recipe_id'] as String?,
  ingredientId: json['ingredient_id'] as String?,
  name: json['name'] as String?,
  quantity: (json['quantity'] as num?)?.toDouble(),
  unit: json['unit'] as String?,
);

Map<String, dynamic> _$RecipeIngredientModelToJson(
  RecipeIngredientModel instance,
) => <String, dynamic>{
  'recipe_ingredientId': instance.recipeIngredientId,
  'recipe_id': instance.recipeId,
  'ingredient_id': instance.ingredientId,
  'name': instance.name,
  'quantity': instance.quantity,
  'unit': instance.unit,
};
