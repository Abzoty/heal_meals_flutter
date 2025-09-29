import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/auth/data/models/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewButton extends StatelessWidget {
  final String recipeId;

  const ReviewButton({super.key, required this.recipeId});

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
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 8.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.black, width: 2.w),
          ),
        ),
        onPressed: () async {
          final userId = await _getUserId(); // ✅ await
          Navigator.pushNamed(
            context,
            AppRoutes.review,
            arguments: {"recipeId": recipeId, "userId": userId},
          );
        },
        child: Text(
          "Write a Review",
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
        ),
      ),
    );
  }
}
