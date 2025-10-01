import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/features/home/data/models/recipe_list_model.dart';
import 'package:heal_meals/features/home/data/models/recipe_model.dart';

class RecipeRepo {
  final ApiServices _apiServices = getIt<ApiServices>();

  Future<ApiResult<List<RecipeListModel>>> getAllRecipes() async {
    try {
      final response = await _apiServices.getAllRecipes();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<List<RecipeListModel>>> getTopPicks() async {
    try {
      final response = await _apiServices.getTopPicks();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<List<RecipeListModel>>> getRecommended() async {
    try {
      final response = await _apiServices.getRecommended();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<RecipeModel>> getRecipeById(String id) async {
    try {
      final response = await _apiServices.getRecipeById(id);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}
