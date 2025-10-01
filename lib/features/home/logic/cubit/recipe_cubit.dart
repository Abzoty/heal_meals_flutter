import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/features/home/data/models/recipe_list_model.dart';
import 'package:heal_meals/features/home/data/models/recipe_model.dart';
import 'package:heal_meals/features/home/data/repositories/recipe_repo.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepo _recipeRepo;

  RecipeCubit({required RecipeRepo recipeRepo})
    : _recipeRepo = recipeRepo,
      super(RecipeInitial());

  Future<void> getTopPicks() async {
    emit(RecipeLoading());
    final result = await _recipeRepo.getTopPicks();
    result.when(
      success: (recipes) => emit(RecipeTopPicsListLoaded(recipes)),
      error: (e) => emit(RecipeError(e)),
    );
  }

  Future<void> getRecommended() async {
    emit(RecipeLoading());
    final result = await _recipeRepo.getRecommended();
    result.when(
      success: (recipes) => emit(RecipeRecommendedListLoaded(recipes)),
      error: (e) => emit(RecipeError(e)),
    );
  }

  Future<void> getAllRecipes() async {
    emit(RecipeLoading());
    final result = await _recipeRepo.getAllRecipes();
    result.when(
      success: (recipes) => emit(RecipeGetAllListLoaded(recipes)),
      error: (e) => emit(RecipeError(e)),
    );
  }

  Future<void> getRecipeById(String id) async {
    emit(RecipeLoading());
    final result = await _recipeRepo.getRecipeById(id);
    result.when(
      success: (recipe) => emit(RecipeLoaded(recipe)),
      error: (e) => emit(RecipeError(e)),
    );
  }

  void loadRecipes() {}
}
