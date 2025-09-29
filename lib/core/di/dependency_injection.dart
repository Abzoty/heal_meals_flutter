import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:heal_meals/core/API/api_services.dart';
import 'package:heal_meals/core/API/dio_factory.dart';
import 'package:heal_meals/features/auth/data/repositories/auth_repository.dart';
import 'package:heal_meals/features/auth/logic/cubit/auth_cubit.dart';
import 'package:heal_meals/features/home/data/repositories/condition_repo.dart';
import 'package:heal_meals/features/home/data/repositories/donation.repo.dart';
import 'package:heal_meals/features/home/data/repositories/notification_repo.dart';
import 'package:heal_meals/features/home/data/repositories/recipe_repo.dart';
import 'package:heal_meals/features/home/data/repositories/review_repo.dart';
import 'package:heal_meals/features/home/logic/cubit/condition_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/donation_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/notification_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/recipe_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/review_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(dio));

  // Repositories 
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<DonationRepository>(() => DonationRepository());
  getIt.registerLazySingleton<RecipeRepo>(() => RecipeRepo());
  getIt.registerLazySingleton<ConditionRepo>(() => ConditionRepo());
  getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepo());
  getIt.registerLazySingleton<ReviewRepo>(() => ReviewRepo());

  // BLoCs 
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<DonationCubit>(
    () => DonationCubit(donationRepository: getIt<DonationRepository>()),
  );
  getIt.registerFactory<RecipeCubit>(
    () => RecipeCubit(recipeRepo: getIt<RecipeRepo>()),
  );
  getIt.registerFactory<ConditionCubit>(
    () => ConditionCubit(conditionRepo: getIt<ConditionRepo>()),
  );
  getIt.registerFactory<NotificationCubit>(
    () => NotificationCubit(notificationRepo: getIt<NotificationRepo>()),
  );
  getIt.registerFactory<ReviewCubit>(
    () => ReviewCubit(reviewRepo: getIt<ReviewRepo>()),
  );
}
