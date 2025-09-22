// features/auth/ui/pages/sign_up_page.dart (Refactored)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/auth/data/models/user_register_model.dart';
import 'package:heal_meals/features/home/ui/widgets/build_text_field.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_auth_button.dart';
import 'package:heal_meals/features/auth/logic/auth_bloc.dart';
import 'package:heal_meals/features/auth/logic/auth_event.dart';
import 'package:heal_meals/features/auth/logic/auth_state.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signup';

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _roleController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  final _addressController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      final userRegisterModel = UserRegisterModel(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        role: 'user', // Default role, TODO: Add role selection
        gender: _genderController.text.trim(),
        dob: _dobController.text.trim(),
        address: '', // TODO: Add address field 
        phone: _phoneController.text.trim(),
      );

      context.read<AuthBloc>().add(
        SignUpRequested(userRegisterModel: userRegisterModel),
      );
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
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  void _showSnackBar(String message, {bool isError = false}) {
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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess) {
          _showSnackBar(state.message);
          Navigator.pushReplacementNamed(context, AppRoutes.signin);
        } else if (state is AuthFailure) {
          _showSnackBar(state.error, isError: true);
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFFF9EDED),
          body: SafeArea(
            child: BlocBuilder<AuthBloc, AuthState>(
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
                            BuildTextField(
                              hintText: "Name",
                              controller: _nameController,
                              validator: (value) =>
                                  _validateRequired(value, 'Name'),
                            ),
                            BuildTextField(
                              hintText: "Email",
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                            ),
                            BuildTextField(
                              hintText: "Password",
                              controller: _passwordController,
                              isPassword: true,
                              validator: _validatePassword,
                            ),
                            BuildTextField(
                              hintText: "Confirm Password",
                              controller: _confirmPasswordController,
                              isPassword: true,
                              validator: _validateConfirmPassword,
                            ),
                            BuildTextField(
                              hintText: "Role",
                              controller: _roleController,
                            ),
                            BuildTextField(
                              hintText: "Phone",
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) =>
                                  _validateRequired(value, 'Phone'),
                            ),
                            BuildTextField(
                              hintText: "Gender",
                              controller: _genderController,
                              validator: (value) =>
                                  _validateRequired(value, 'Gender'),
                            ),
                            BuildTextField(
                              hintText: "Address",
                              controller: _addressController,
                              validator: (value) =>
                                  _validateRequired(value, 'Name'),
                            ),
                            BuildTextField(
                              hintText: "Date of Birth (YYYY-MM-DD)",
                              controller: _dobController,
                              validator: (value) =>
                                  _validateRequired(value, 'Date of Birth'),
                            ),

                            SizedBox(height: 30.h),

                            // Sign up button
                            CustomAuthButton(
                              onPressed: state is AuthLoading
                                  ? () {}
                                  : _handleSignUp,
                              buttonText: state is AuthLoading
                                  ? 'Signing up...'
                                  : 'Sign up',
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
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.signin,
                                    );
                                  },
                                  child: Text(
                                    "Sign in",
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
