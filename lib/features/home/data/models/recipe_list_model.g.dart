// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeListModel _$RecipeListModelFromJson(Map<String, dynamic> json) =>
    RecipeListModel(
      recipeId: json['recipe_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      stars: (json['stars'] as num).toInt(),
    );

Map<String, dynamic> _$RecipeListModelToJson(RecipeListModel instance) =>
    <String, dynamic>{
      'recipe_id': instance.recipeId,
      'title': instance.title,
      'description': instance.description,
      'stars': instance.stars,
    };
