import 'package:flutter/material.dart';
import 'package:heal_meals/core/routing/routes.dart';

class DiscoverMoreButton extends StatelessWidget {
  const DiscoverMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFB22B28),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          minimumSize: Size.zero, // 👈 makes button shrink to fit content
          tapTargetSize:
              MaterialTapTargetSize.shrinkWrap, // 👈 removes extra padding
        ),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.discover);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min, // 👈 Row also shrink-wraps
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Discover More Recipes",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(width: 8),
            Icon(Icons.explore, color: Colors.white, size: 22),
          ],
        ),
      ),
    );
  }
}
