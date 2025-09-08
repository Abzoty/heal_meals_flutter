import 'package:flutter/material.dart';

class DiscoverFilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DiscoverFilterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.filter_list, color: Colors.white),
        label: const Text('Filters', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: const Color(0xFF1B512D),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        ),
      ),
    );
  }
}
