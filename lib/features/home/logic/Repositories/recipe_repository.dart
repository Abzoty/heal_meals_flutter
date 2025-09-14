import 'package:heal_meals/features/home/data/models/recipe_model.dart';
import '../../../../core/API/api_client.dart';
import '../../../../core/API/endpoints.dart';

class RecipeRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Recipe> getSpecificRecipe(String id) async {
    final json = await _apiClient.get('${Endpoints.getSpecificRecipe}$id');

    if (json is Map<String, dynamic>) {
      return Recipe.fromJson(json);
    }
    throw Exception("Unexpected response format for getSpecificRecipe");
  }

  Future<List<Recipe>> getAllRecipes() async {
    final json = await _apiClient.get(Endpoints.getAllRecipes);

    if (json is List) {
      return json
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (json is Map && json['data'] is List) {
      return (json['data'] as List)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw Exception("Unexpected response format for getAllRecipes");
  }
}
