import 'package:flutter/material.dart';
import 'package:heal_meals/features/home/ui/pages/discover_page.dart';
import 'package:heal_meals/features/home/ui/pages/donation_page.dart';
import 'package:heal_meals/features/home/ui/pages/favorites_page.dart';
import 'package:heal_meals/features/home/ui/pages/health_profile_page.dart';
import 'package:heal_meals/features/home/ui/pages/home_page.dart';
import 'package:heal_meals/features/auth/ui/pages/sign_up_page.dart';
import 'package:heal_meals/features/auth/ui/pages/sign_in_page.dart';
import 'package:heal_meals/features/home/ui/pages/recipe_page.dart';
import 'package:heal_meals/features/home/ui/pages/start_screen.dart';
import 'package:heal_meals/features/home/ui/widgets/testing_page.dart';
import 'package:heal_meals/features/home/ui/pages/profile_page.dart'; 


class AppRoutes {
  static const String start = '/';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String testing = '/testing';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String favorites = '/favorites';
  static const String donation = '/donation';
  static const String recipe = '/recipe';
  static const String discover = '/discover';
  static const String healthProfile = '/healthProfile';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case start:
        return MaterialPageRoute(builder: (_) => const StartScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());
      case signin:
        return MaterialPageRoute(builder: (_) => const LogInPage());
      case testing:
        return MaterialPageRoute(builder: (_) => const TestingPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      case donation:
        return MaterialPageRoute(builder: (_) => const DonationPage());
      case recipe:
        return MaterialPageRoute(builder: (_) => const RecipePage());
      case discover:
        return MaterialPageRoute(builder: (_) => const DiscoverPage());
      case healthProfile:
        return MaterialPageRoute(builder: (_) => const HealthProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
