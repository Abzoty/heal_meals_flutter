class ApiConstants {
  // Shared Preferences
  static const String token = 'token';

  // Endpoints
  static const String baseUrl = 'https://e559c301-1020-41f9-bfbe-39a943840df6.mock.pstmn.io';
  //auth
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  //recipes
  static const String getAllRecipes = '/api/recipes';
  static const String getRecipeById = '/api/recipes/{recipe_id}';
  //TODO
  static const String getTopPicks = '/api/...';
  static const String getRecommended = '/api/...';
  //favorites
  static const String getFavorites = '/api/favorites';
  static const String addToFavorites = '/api/favorites/{recipe_id}';
  static const String removeFromFavorites = '/api/favorites/{recipe_id}';
  //conditions
  static const String getAllConditions = '/api/profile-conditions';
  static const String getAllUserConditions = '/api/user-conditions';
  static const String addUserCondition = '/api/user-conditions/{user_id}/{condition_id}';
  static const String deleteUserCondition = '/api/user-conditions/{user_condition_id}';
  //donations
  static const String makeDonation = '/api/donations';
}
