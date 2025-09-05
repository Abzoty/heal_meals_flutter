import 'package:flutter/material.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';


class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  // Example user data (replace with real user info from your backend or state)
  final Map<String, String> userInfo = const {
    "Name": "John Doe",
    "Email": "john.doe@example.com",
    "Phone": "+1 555 123 4567",
    "Address": "123 Green Street",
    "State": "California",
    "City": "Los Angeles",
    "Gender": "Male",
    "Age": "29",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9EDED),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // Profile Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF4B5D2A), // Green circle
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // User Information Display
              ...userInfo.entries.map(
                (entry) =>
                    _buildInfoField(label: entry.key, value: entry.value),
              ),

              const SizedBox(height: 20),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B5D2A), // Dark green
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.healthProfile);
                  },
                  child: const Text(
                    "Health Profile",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentPage: 'profile'),
    );
  }

  Widget _buildInfoField({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF5EDED), // Slightly lighter pink
              borderRadius: BorderRadius.circular(12),
              border: const Border(
                bottom: BorderSide(
                  width: 0.5,
                  color: Colors.grey,
                ),
              ),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}