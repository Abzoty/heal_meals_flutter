import 'package:flutter/material.dart';

class DiscoverSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const DiscoverSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
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
          textInputAction:
              TextInputAction.search, // ✅ makes keyboard show "search"
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: onSearch, // ✅ search icon
            ),
            border: InputBorder.none,
            hintText: 'Search recipes',
            hintStyle: const TextStyle(color: Colors.grey),
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onSubmitted: (_) => onSearch(), // ✅ keyboard search button
        ),
      ),
    );
  }
}