import 'package:dio/dio.dart';
import 'package:heal_meals/features/home/data/models/condition_model.dart';
import 'package:heal_meals/features/home/data/models/recipe_list_model.dart';
import 'package:heal_meals/features/home/data/models/recipe_model.dart';
import 'package:heal_meals/features/auth/data/models/user_login_model.dart';
import 'package:heal_meals/features/auth/data/models/user_register_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:heal_meals/core/API/api_constants.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.phoneBaseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio) => _ApiServices(dio);

  //Register
  @POST(ApiConstants.register)
  Future<dynamic> register(@Body() UserRegisterModel body);

  //Login
  @POST(ApiConstants.login)
  Future<dynamic> login(@Body() UserLoginModel body);

  //get all recipes
  @GET(ApiConstants.getAllRecipes)
  Future<List<RecipeListModel>> getAllRecipes();

  //get recipe by id
  @GET(ApiConstants.getRecipeById)
  Future<RecipeModel> getRecipeById(@Path("recipe_id") String id);
  
  //get all favorite recipes
  @GET(ApiConstants.getFavorites)
  Future<List<RecipeListModel>> getAllFavorites();

  //get top picks in recipes
  @GET(ApiConstants.getTopPicks)
  Future<List<RecipeListModel>> getTopPicks();

  //get recommended recipes
  @GET(ApiConstants.getRecommended)
  Future<List<RecipeListModel>> getRecommended();

  //add recipe to favorites
  @POST(ApiConstants.addToFavorites)
  Future<dynamic> addToFavorites(@Path("recipe_id") String recipeId);

  //remove recipe from favorites
  @DELETE(ApiConstants.removeFromFavorites)
  Future<dynamic> removeFromFavorites(@Path("recipe_id") String recipeId);

  //get all condition
  @GET(ApiConstants.getAllConditions)
  Future<List<ConditionModel>> getAllConditions();

  //get all user conditions 
  @GET(ApiConstants.getAllUserConditions)
  Future<List<ConditionModel>> getAllUserConditions();

  //TODO
  //get all user conditions (diseases)
  //get all user conditions (allergies)

  //add user condition
  @POST(ApiConstants.addUserCondition)
  Future<dynamic> addUserCondition(@Path("user_id") String userId, @Path("condition_id") String conditionId);

  //delete user condition
  @DELETE(ApiConstants.deleteUserCondition)
  Future<dynamic> deleteUserCondition(@Path("user_condition_id") String userId);

  //make a donation
  @POST(ApiConstants.makeDonation)
  Future<dynamic> makeDonation(@Body() Map<String, dynamic> body);
}
