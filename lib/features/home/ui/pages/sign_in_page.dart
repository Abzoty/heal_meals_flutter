import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/heal_meals_logo.png",
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Form fields
                BuildTextField(hintText: "Email"),
                BuildTextField(hintText: "Password", isPassword: true),
                const SizedBox(height: 30),

                // Sign up button
                CustomAuthButton(
                  onPressed: () {
                    // TODO: Implement sign up logic
                    Navigator.pushNamed(context, AppRoutes.home);
                  },
                  buttonText: 'Sign In',
                ),

                const SizedBox(height: 20),

                // Sign in link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.signup);
                      },
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signup);
                        },
                        child: const Text(
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

