import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:heal_meals/core/API/api_constants.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio) => _ApiServices(dio);
} 