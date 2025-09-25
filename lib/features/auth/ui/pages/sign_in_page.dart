// features/auth/ui/pages/sign_in_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/auth/data/models/user_login_model.dart';
import 'package:heal_meals/features/auth/logic/cubit/auth_cubit.dart';
import 'package:heal_meals/features/auth/logic/cubit/auth_state.dart';
import 'package:heal_meals/features/home/ui/widgets/build_text_field.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_auth_button.dart';

class SignInPage extends StatelessWidget {
  static const routeName = '/signin';

  SignInPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final userLoginModel = UserLoginModel(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      context.read<AuthCubit>().signIn(userLoginModel);
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignInSuccess) {
          _showSnackBar(context, "Login successful!");
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state is AuthFailure) {
          _showSnackBar(context, 'Sign in failed', isError: true);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFFF9EDED),
          body: SafeArea(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 40.h,
                      ),
                      child: Form(
                        key: _formKey,
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

                            // Email field
                            BuildTextField(
                              hintText: "Email",
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                            ),

                            // Password field
                            BuildTextField(
                              hintText: "Password",
                              controller: _passwordController,
                              isPassword: true,
                              validator: _validatePassword,
                            ),

                            SizedBox(height: 30.h),

                            // Sign in button
                            CustomAuthButton(
                              onPressed: state is AuthLoading
                                  ? () {}
                                  : () => _handleLogin(context),
                              buttonText: state is AuthLoading
                                  ? 'Signing in...'
                                  : 'Sign in',
                            ),

                            SizedBox(height: 20.h),

                            // Sign up link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.signup,
                                    );
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Loading overlay
                    if (state is AuthLoading)
                      Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
