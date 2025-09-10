import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Scaffold(
            bottomNavigationBar: const CustomNavBar(currentPage: 'home'),
          ),
        ),
      ),
    );
  }
}

