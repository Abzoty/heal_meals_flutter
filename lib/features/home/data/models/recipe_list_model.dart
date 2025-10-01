import 'package:json_annotation/json_annotation.dart';

part 'recipe_list_model.g.dart';

@JsonSerializable()
class RecipeListModel {
  @JsonKey(name: 'recipe_id')
  final String recipeId;
  final String title;
  final String description;
  final int stars;

  RecipeListModel({
    required this.recipeId,
    required this.title,
    required this.description,
    required this.stars,
  });

  factory RecipeListModel.fromJson(Map<String, dynamic> json) => _$RecipeListModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeListModelToJson(this);
}