import 'package:flutter/material.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/home/data/models/profile_model.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/logic/API/profile_repository.dart';
import 'package:heal_meals/features/home/ui/widgets/info_filed.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileRepository _repository = ProfileRepository();

  Profile? _profile;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final data = await _repository.getProfile();
      setState(() {
        _profile = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9EDED),
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
                  color: Color(0xFF1B512D),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_circle,
                  size: 80,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 24),

              // Loading, Error, or Data
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_error != null)
                Text(
                  "Error: $_error",
                  style: const TextStyle(color: Colors.red),
                )
              else if (_profile != null) ...[
                InfoField(label: "Name", value: _profile!.name),
                InfoField(label: "Email", value: _profile!.email),
                InfoField(label: "Role", value: _profile!.role),
                InfoField(label: "Gender", value: _profile!.gender),
                InfoField(label: "Date of Birth", value: _profile!.dateOfBirth),
                InfoField(label: "Address", value: _profile!.address),
                InfoField(label: "Phone", value: _profile!.phone),
                InfoField(label: "Health ID", value: _profile!.healthId),
              ],

              const SizedBox(height: 20),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B512D),
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
}
