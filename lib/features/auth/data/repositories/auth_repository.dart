import 'dart:convert';
import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/core/helper/shared_pref.dart';
import 'package:heal_meals/core/API/api_constants.dart';
import 'package:heal_meals/features/auth/data/models/user_login_model.dart';
import 'package:heal_meals/features/auth/data/models/user_profile_model.dart';
import 'package:heal_meals/features/auth/data/models/user_register_model.dart';

class AuthRepository {
  final ApiServices _apiServices = getIt<ApiServices>();

  Future<ApiResult<Map<String, dynamic>>> register(
    UserRegisterModel userRegisterModel,
  ) async {
    try {
      final response = await _apiServices.register(userRegisterModel);
      return ApiResult.success(response as Map<String, dynamic>);
    } catch (e) {
      return ApiResult.error(_handleError(e));
    }
  }

  Future<ApiResult<Map<String, dynamic>>> login(
    UserLoginModel userLoginModel,
  ) async {
    try {
      final response = await _apiServices.login(userLoginModel);
      return ApiResult.success(response as Map<String, dynamic>);
    } catch (e) {
      return ApiResult.error(_handleError(e));
    }
  }

  Future<void> saveToken(String token) async {
    await SharedPrefHelper.setSecuredString(ApiConstants.token, token);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    final userString = jsonEncode(user); // Model → Map → String
    await SharedPrefHelper.setData(ApiConstants.user, userString);
  }

  Future<String> getToken() async {
    return await SharedPrefHelper.getSecuredString(ApiConstants.token);
  }

  Future<UserProfileModel?> getUser() async {
    final userString = await SharedPrefHelper.getString(ApiConstants.user);
    if (userString.isEmpty) return null;

    final Map<String, dynamic> userMap = jsonDecode(userString);
    return UserProfileModel.fromJson(userMap);
  }


  Future<void> logout() async {
    await SharedPrefHelper.clearAllSecuredData();
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token.isNotEmpty;
  }

  String _handleError(dynamic error) {
    // Handle different types of errors (network, server, etc.)
    if (error.toString().contains('SocketException')) {
      return 'No internet connection';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Request timeout';
    } else if (error.toString().contains('404')) {
      return 'Service not found';
    } else if (error.toString().contains('500')) {
      return 'Server error';
    }
    return 'Something went wrong: ${error.toString()}';
  }
}
