import 'package:flutter/material.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';
import 'package:heal_meals/features/home/ui/widgets/build_text_field.dart';

class DonationPage extends StatelessWidget {
  static const String routeName = '/donation';
  const DonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        bottomNavigationBar: const CustomNavBar(currentPage: 'donation'),
        backgroundColor: Color(0xFFF9EDED),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/donation.png",
                        width: 216,
                        height: 216,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Form fields
                BuildTextField(hintText: 'Full Name'),
                BuildTextField(hintText: 'Phone Number'),
                BuildTextField(hintText: 'Email'),
                BuildTextField(hintText: 'Password', isPassword: true),
                BuildTextField(hintText: 'Message'),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    "Credit Card Information",
                    style: TextStyle(
                      color: Color(0XFF787575),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BuildDoubleTextField(
                  hintText1: "First Name",
                  hintText2: "Last Name",
                ),
                const BuildTripleTextField(
                  hintText1: "Card Number",
                  hintText2: "MM/YY",
                  hintText3: "CVV",
                  flex1: 3,
                  flex2: 2,
                  flex3: 2,
                ),

                const SizedBox(height: 30),

                // Sign up button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Handle donation Submit logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6E8640),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      'Submit',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
