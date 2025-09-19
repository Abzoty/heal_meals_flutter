import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_meals/features/home/ui/widgets/build_text_field.dart';
import 'package:heal_meals/features/home/ui/widgets/custom_nav_bar.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/donation.png",
                        width: 216.w,
                        height: 216.h,
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),

                // Form fields
                BuildDoubleTextField(hintText1: 'First Name', hintText2: 'Second Name'),
                BuildTextField(hintText: 'Phone Number'),
                BuildTextField(hintText: 'Email'),
                BuildTextField(hintText: 'Amount'),
                BuildTextField(hintText: 'Message'),
                SizedBox(height: 30.h),
                Center(
                  child: Text(
                    "Credit Card Information",
                    style: TextStyle(
                      color: Color(0XFF787575),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const BuildTripleTextField(
                  hintText1: "Card Number",
                  hintText2: "MM/YY",
                  hintText3: "CVV",
                  flex1: 3,
                  flex2: 2,
                  flex3: 2,
                ),

                SizedBox(height: 30.h),

                // Sign up button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Handle donation Submit logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1B512D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18.sp,
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
