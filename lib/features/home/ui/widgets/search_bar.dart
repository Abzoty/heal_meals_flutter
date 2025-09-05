import 'package:flutter/material.dart';

class DiscoverSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onSubmitted;

  const DiscoverSearchBar({
    super.key,
    required this.controller,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Container(
        padding: const EdgeInsets.only(right: 8, left: 30),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(22),
        ),
        child: TextField(
          controller: controller,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.search),
            border: InputBorder.none,
            hintText: 'Search recipes',
            hintStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}
