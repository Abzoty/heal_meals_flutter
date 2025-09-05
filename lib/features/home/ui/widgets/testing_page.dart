import 'package:flutter/material.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';

class TestingPage extends StatelessWidget {
  const TestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Scaffold(
            bottomNavigationBar: const CustomNavBar(currentPage: 'home'),
          ),
        ),
      ),
    );
  }
}
