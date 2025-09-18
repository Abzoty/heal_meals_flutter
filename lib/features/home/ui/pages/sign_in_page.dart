import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_auth_button.dart';
import 'package:heal_meals/features/home/ui/widgets/build_text_field.dart';

class LogInPage extends StatelessWidget {
  static const routeName = '/signin';

  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFFF9EDED),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/heal_meals_logo.png",
                        width: 150.w,
                        height: 150.h,
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.h),

                // Form fields
                BuildTextField(hintText: "Email"),
                BuildTextField(hintText: "Password", isPassword: true),
                SizedBox(height: 30.h),

                // Sign up button
                CustomAuthButton(
                  onPressed: () {
                    // TODO: Implement sign up logic
                    Navigator.pushNamed(context, AppRoutes.home);
                  },
                  buttonText: 'Sign In',
                ),

                SizedBox(height: 20.h),

                // Sign in link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signup);
                      },
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signup);
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

