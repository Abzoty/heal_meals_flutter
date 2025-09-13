import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/home/ui/widgets/build_text_field.dart';
import 'package:heal_meals/features/auth/ui/widgets/custom_auth_button.dart';


class SignupPage extends StatelessWidget {
  static const routeName = '/signup';

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9EDED),
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
                        "Sign up",
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
                BuildTextField(hintText: "Name"),
                BuildTextField(hintText: "Email"),
                BuildTextField(hintText: "Password", isPassword: true),
                BuildTextField(hintText: "Confirm Password", isPassword: true),
                BuildTextField(hintText: "Phone"),
                BuildTextField(hintText: "Gender"),
                BuildTextField(hintText: "Age"),

                SizedBox(height: 30.h),

                // Sign up button
                CustomAuthButton(
                  onPressed: () {
                    // TODO: Implement sign up logic
                    Navigator.pushNamed(context, AppRoutes.signin);
                  },
                  buttonText: 'Sign up',
                ),

                SizedBox(height: 20.h),

                // Sign in link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account? ",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signin);
                      },
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signin);
                        },
                        child: Text(
                          "Sign in",
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

