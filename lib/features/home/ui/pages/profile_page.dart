import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/home/data/models/user_model.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/logic/Repositories/user_repository.dart';
import 'package:heal_meals/features/home/ui/widgets/info_filed.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserRepository _repository = UserRepository();

  User? _profile;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    try {
      final data = await _repository.getUser("1");
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

              SizedBox(height: 24.h),

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
                InfoField(label: "Date of Birth", value: _profile!.dob),
                InfoField(label: "Address", value: _profile!.address),
                InfoField(label: "Phone", value: _profile!.phone),
                //InfoField(label: "Health ID", value: _profile!.healthId),
              ],

              SizedBox(height: 20.h),

              // Button
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
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.healthProfile);
                  },
                  child: Text(
                    "Health Profile",
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
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
