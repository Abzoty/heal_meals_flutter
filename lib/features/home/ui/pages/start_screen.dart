import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:heal_meals/core/routing/routes.dart";

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  static const routeName = '/start-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3DB766),
              Color(0xFF2D995D),
              Color(0xFF1C7C54),
              Color(0xFF1B512D),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/heal_meals_logo.png",
                width: 350.w,
                height: 350.h,
                color: Colors.white,
              ),
              Text(
                "Heal Meals",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48.sp,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Eat Well, Live Better",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80.h),
              SizedBox(
                height: 50.h,
                width: 300.w,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the sign-up screen
                    Navigator.pushNamed(context, AppRoutes.signup);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B512D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    animationDuration: const Duration(milliseconds: 200),
                    elevation: 5,
                    shadowColor: Colors.white10,
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

