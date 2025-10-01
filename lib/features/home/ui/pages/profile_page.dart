import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/auth/data/models/user_profile_model.dart';
import 'package:heal_meals/features/auth/logic/cubit/auth_cubit.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/info_filed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  Future<UserProfileModel> _getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson == null) {
      throw Exception('No user data found');
    }

    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    return UserProfileModel.fromJson(userMap);
  }

  Future<String> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) return '';
    final userMap = jsonDecode(userJson) as Map<String, dynamic>;
    final user = UserProfileModel.fromJson(userMap);
    return user.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EDED),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.h),

              // Profile Icon
              Container(
                padding: EdgeInsets.all(20.r),
                decoration: const BoxDecoration(
                  color: Color(0xFF1B512D),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_circle,
                  size: 80.r,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 16.h),

              // User Profile Data
              FutureBuilder<UserProfileModel>(
                future: _getUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        SizedBox(height: 24.h),
                        const CircularProgressIndicator(),
                        SizedBox(height: 24.h),
                      ],
                    );
                  }

                  if (snapshot.hasError) {
                    return Column(
                      children: [
                        SizedBox(height: 24.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: Colors.red[200]!),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Error: ${snapshot.error}",
                                style: TextStyle(
                                  color: Colors.red[700],
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              TextButton.icon(
                                onPressed: () {
                                  // Trigger rebuild by calling setState equivalent
                                  // Since we're stateless, we can use Navigator to refresh
                                  Navigator.pushReplacementNamed(
                                    context,
                                    ProfilePage.routeName,
                                  );
                                },
                                icon: Icon(
                                  Icons.refresh,
                                  color: Colors.red[700],
                                  size: 16.sp,
                                ),
                                label: Text(
                                  "Retry",
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    );
                  }

                  final profile = snapshot.data!;

                  return Column(
                    children: [
                      // User Name Display
                      Text(
                        profile.name,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1B512D),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Profile Information Fields
                      InfoField(label: "Email", value: profile.email),
                      InfoField(label: "Role", value: profile.role),
                      InfoField(label: "Gender", value: profile.gender),
                      InfoField(label: "Date of Birth", value: profile.dob),
                      InfoField(label: "Address", value: profile.address),
                      InfoField(label: "Phone", value: profile.phone),
                    ],
                  );
                },
              ),

              SizedBox(height: 32.h),

              // Health Profile Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B512D),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () async {
                    final userId = await _getUserId();
                    if (!context.mounted) return;
                    Navigator.pushNamed(
                      context,
                      AppRoutes.healthProfile,
                      arguments: userId,
                    );
                  },
                  child: Text(
                    "Health Profile",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // 🔴 Logout Text
              TextButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.signin,
                    (route) => false, // Remove all routes
                  );
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'profile'),
    );
  }
}
