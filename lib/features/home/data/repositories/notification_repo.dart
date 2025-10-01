import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/features/home/data/models/notification_model.dart';

class NotificationRepo {
  final ApiServices _apiServices = getIt<ApiServices>();

  Future<ApiResult<List<NotificationModel>>> getAllNotifications(
    String email,
  ) async {
    try {
      final response = await _apiServices.getAllNotifications(email);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<List<NotificationModel>>> getUnreadNotifications(
    String email,
  ) async {
    try {
      final response = await _apiServices.getUnreadNotifications(email);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }

  Future<ApiResult<String>> markNotificationAsRead(
    String notificationId,
  ) async {
    try {
      final response = await _apiServices.markNotificationAsRead(
        notificationId,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e.toString());
    }
  }
}
