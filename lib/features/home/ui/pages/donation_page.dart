// features/donation/ui/pages/donation_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/core/routing/routes.dart';
import 'package:heal_meals/features/home/data/models/donation_model.dart';
import 'package:heal_meals/features/home/logic/cubit/donation_cubit.dart';
import 'package:heal_meals/features/home/logic/cubit/donation_state.dart';
import 'package:heal_meals/features/home/ui/widgets/build_text_field.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_auth_button.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';

class DonationPage extends StatelessWidget {
  static const routeName = '/donation';

  DonationPage({super.key});

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _firstNameController = TextEditingController();
  final _secondNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  void _handleDonation(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final donation = DonationModel(
        firstName: _firstNameController.text.trim(),
        secondName: _secondNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        amount: double.tryParse(_amountController.text.trim()) ?? 0,
        message: _messageController.text.trim(),
        cardNumber: _cardNumberController.text.trim(),
        expiryDate: _expiryController.text.trim(),
        cvv: _cvvController.text.trim(),
      );

      context.read<DonationCubit>().makeDonation(donation);
    }
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DonationCubit, DonationState>(
      listener: (context, state) {
        if (state is DonationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Donation made Successfully"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state is DonationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Donation Failed, try again with correct details"), backgroundColor: Colors.red),
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          bottomNavigationBar: const CustomNavBar(currentPage: 'donation'),
          backgroundColor: const Color(0xFFF9EDED),
          body: SafeArea(
            child: BlocBuilder<DonationCubit, DonationState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 40.h,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logo
                            Center(
                              child: Column(
                                children: [
                                  Image.asset(
                                    "assets/images/donation.png",
                                    width: 150.w,
                                    height: 150.h,
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    "Make a Donation",
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h),

                            // Form fields
                            Row(
                              children: [
                                Expanded(
                                  child: BuildTextField(
                                    hintText: "First Name",
                                    controller: _firstNameController,
                                    validator: (v) =>
                                        _validateRequired(v, 'First Name'),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: BuildTextField(
                                    hintText: "Second Name",
                                    controller: _secondNameController,
                                    validator: (v) =>
                                        _validateRequired(v, 'Second Name'),
                                  ),
                                ),
                              ],
                            ),
                            BuildTextField(
                              hintText: "Phone Number",
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (v) => _validateRequired(v, 'Phone'),
                            ),
                            BuildTextField(
                              hintText: "Email",
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                            ),
                            BuildTextField(
                              hintText: "Amount",
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              validator: (v) => _validateRequired(v, 'Amount'),
                            ),
                            BuildTextField(
                              hintText: "Message",
                              controller: _messageController,
                            ),

                            SizedBox(height: 30.h),
                            Center(
                              child: Text(
                                "Credit Card Information",
                                style: TextStyle(
                                  color: const Color(0XFF787575),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            BuildTextField(
                              hintText: "Card Number",
                              controller: _cardNumberController,
                              keyboardType: TextInputType.number,
                              validator: (v) =>
                                  _validateRequired(v, 'Card Number'),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: BuildTextField(
                                    hintText: "MM/YY",
                                    controller: _expiryController,
                                    validator: (v) =>
                                        _validateRequired(v, 'Expiry Date'),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex: 1,
                                  child: BuildTextField(
                                    hintText: "CVV",
                                    controller: _cvvController,
                                    keyboardType: TextInputType.number,
                                    validator: (v) =>
                                        _validateRequired(v, 'CVV'),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 30.h),

                            // Donate button
                            CustomAuthButton(
                              onPressed: state is DonationLoading
                                  ? () {}
                                  : () => _handleDonation(context),
                              buttonText: state is DonationLoading
                                  ? 'Submitting...'
                                  : 'Submit',
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Loading overlay
                    if (state is DonationLoading)
                      Container(
                        color: Colors.black.withValues(alpha: 0.3),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
