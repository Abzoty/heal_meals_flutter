part of 'recipe_cubit.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeTopPicsListLoaded extends RecipeState {
  final List<RecipeListModel> recipes;

  const RecipeTopPicsListLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeGetAllListLoaded extends RecipeState {
  final List<RecipeListModel> recipes;

  const RecipeGetAllListLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeRecommendedListLoaded extends RecipeState {
  final List<RecipeListModel> recipes;

  const RecipeRecommendedListLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeLoaded extends RecipeState {
  final RecipeModel recipes;

  const RecipeLoaded(this.recipes);

  @override
  List<Object> get props => [recipes];
}

class RecipeError extends RecipeState {
  final String message;

  const RecipeError(this.message);

  @override
  List<Object> get props => [message];
}
