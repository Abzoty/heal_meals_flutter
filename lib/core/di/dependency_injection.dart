import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/API/dio_factory.dart';
import 'package:heal_meals/features/auth/data/repositories/auth_repository.dart';
import 'package:heal_meals/features/auth/logic/auth_bloc.dart';

final getIt= GetIt.instance;
Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());

  // BLoCs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: getIt<AuthRepository>()),
  );
}