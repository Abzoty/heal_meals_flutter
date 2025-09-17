import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/API/dio_factory.dart';

final getIt= GetIt.instance;
Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio));
}