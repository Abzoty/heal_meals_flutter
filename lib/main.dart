import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/di/dependency_injection.dart';
import 'package:heal_meals/features/auth/logic/auth_bloc.dart';
import 'package:heal_meals/features/auth/logic/auth_event.dart';
import 'core/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await setupGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 844), // base size (adjust to your Figma/UI)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<AuthBloc>()..add(CheckAuthStatus()),
            ),
            // Add other BLoCs here as you create them
            // BlocProvider(create: (context) => getIt<RecipeBloc>()),
            // BlocProvider(create: (context) => getIt<FavoritesBloc>()),
          ],
          child: MaterialApp(
            title: 'Heal Meals',
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.start,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
