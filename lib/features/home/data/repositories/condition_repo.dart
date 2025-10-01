import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/features/home/data/models/condition_model.dart';
import 'package:heal_meals/features/home/data/models/user_condition_model.dart';

class ConditionRepo {
  final ApiServices _apiServices = getIt<ApiServices>();

  Future<ApiResult<List<ConditionModel>>> getAllConditions() async {
    try {
      final response = await _apiServices.getAllConditions();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<List<UserConditionModel>>> getAllUserConditions(String userId) async {
    try {
      final response = await _apiServices.getAllUserConditions(userId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<Map<String, dynamic>>> addUserCondition(
    String userId,
    String conditionId,
  ) async {
    try {
      final response = await _apiServices.addUserCondition(userId, conditionId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<String>> deleteUserCondition(String userConditionId) async {
    try {
      final response = await _apiServices.deleteUserCondition(userConditionId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}