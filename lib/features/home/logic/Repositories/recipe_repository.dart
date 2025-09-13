import 'package:heal_meals/features/home/data/models/recipe_model.dart';
import '../../../../core/API/api_client.dart';
import '../../../../core/API/endpoints.dart';

class RecipeRepository {
  final ApiClient _apiClient = ApiClient();

  Future<Recipe> getSpecificRecipe() async {
    final json = await _apiClient.get(Endpoints.getSpecificRecipe);
    return Recipe.fromJson(json);
  }
}