import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/core/helper/shared_pref.dart';
import 'package:heal_meals/features/auth/logic/cubit/auth_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/condition_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/donation_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/notification_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/recipe_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/review_cubit.dart';
import 'package:heal_meals/features/home/ui/pages/discover_page.dart';
import 'package:heal_meals/features/home/ui/pages/donation_page.dart';
import 'package:heal_meals/features/home/ui/pages/favorites_page.dart';
import 'package:heal_meals/features/home/ui/pages/health_profile_page.dart';
import 'package:heal_meals/features/home/ui/pages/home_page.dart';
import 'package:heal_meals/features/auth/ui/pages/sign_up_page.dart';
import 'package:heal_meals/features/auth/ui/pages/sign_in_page.dart';
import 'package:heal_meals/features/home/ui/pages/notifications_page.dart';
import 'package:heal_meals/features/home/ui/pages/review_page.dart';
import 'package:heal_meals/features/home/ui/pages/start_screen.dart';
import 'package:heal_meals/features/home/ui/widgets/testing_page.dart';
import 'package:heal_meals/features/home/ui/pages/profile_page.dart';

class AppRoutes {
  static const String start = '/';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String testing = '/testing';
  static const String home = '/home';
  static const String recipe = '/recipe';
  static const String profile = '/profile';
  static const String favorites = '/favorites';
  static const String donation = '/donation';
  static const String discover = '/discover';
  static const String healthProfile = '/healthProfile';
  static const String notifications = '/notifications';
  static const String review = '/review';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case start:
        return MaterialPageRoute(builder: (_) => const StartScreen());

      case signup:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: SignupPage(),
          ),
        );

      case signin:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<AuthCubit>(),
            child: SignInPage(),
          ),
        );

      case testing:
        return MaterialPageRoute(builder: (_) => const TestingPage());

      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<RecipeCubit>(),
            child: const HomePage(),
          ),
        );

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());

      case donation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<DonationCubit>(),
            child: DonationPage(),
          ),
        );

      case discover:
        return MaterialPageRoute(builder: (_) => const DiscoverPage());

      case healthProfile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ConditionCubit>()
              ..getAllConditions()
              ..getUserConditions(),
            child: const HealthProfilePage(),
          ),
        );

      case notifications:
        return MaterialPageRoute(
          builder: (_) => FutureBuilder<String?>(
            future: SharedPrefHelper.getString("user"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final userJson = snapshot.data!;
              final userMap = jsonDecode(userJson) as Map<String, dynamic>;
              final userEmail = userMap["email"] as String;

              return BlocProvider(
                create: (_) =>
                    getIt<NotificationCubit>()..getAllNotifications(userEmail),
                child: const NotificationsPage(),
              );
            },
          ),
        );

        case review:
        final args = settings.arguments as Map<String, dynamic>;
        final recipeId = args['recipeId'] as String;
        final userId = args['userId'] as String;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ReviewCubit>(),
            child: ReviewPage(recipeId: recipeId, userId: userId),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
