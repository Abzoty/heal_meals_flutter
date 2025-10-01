import 'package:heal_meals/core/API/api_result.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/features/home/data/models/review_model.dart';

class ReviewRepo {
  final ApiServices _apiServices = getIt<ApiServices>();

  Future<ApiResult<ReviewModel>> makeReview(ReviewModel review)async {
    try {
      final response = await _apiServices.makeReview(review);
      return ApiResult.success(response);
    }
    catch(e){
      return ApiResult.error(e.toString());
    }
  }
}