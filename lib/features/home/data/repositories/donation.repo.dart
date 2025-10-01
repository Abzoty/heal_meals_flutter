import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/features/home/data/models/donation_model.dart';

class DonationRepository {
  final ApiServices _apiServices = getIt<ApiServices>();

  Future<ApiResult<Map<String, dynamic>>> makeDonation(DonationModel donationModel) async {
    try {
      final response = await _apiServices.makeDonation(donationModel);
      return ApiResult.success(response as Map<String, dynamic>);
    } catch (e) {
      return ApiResult.error(_handleError(e));
    }
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