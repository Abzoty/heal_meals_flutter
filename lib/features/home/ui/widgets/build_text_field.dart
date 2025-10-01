import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const BuildTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hintText,
          border: UnderlineInputBorder(borderSide: BorderSide(width: 2.w)),
          errorStyle: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }
}

class BuildDoubleTextField extends StatelessWidget {
  final String hintText1;
  final String hintText2;
  final bool isPassword1;
  final bool isPassword2;
  final TextEditingController? controller1;
  final TextEditingController? controller2;
  final String? Function(String?)? validator1;
  final String? Function(String?)? validator2;
  final TextInputType? keyboardType1;
  final TextInputType? keyboardType2;

  const BuildDoubleTextField({
    super.key,
    required this.hintText1,
    required this.hintText2,
    this.isPassword1 = false,
    this.isPassword2 = false,
    this.controller1,
    this.controller2,
    this.validator1,
    this.validator2,
    this.keyboardType1,
    this.keyboardType2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller1,
              obscureText: isPassword1,
              validator: validator1,
              keyboardType: keyboardType1,
              decoration: InputDecoration(
                labelText: hintText1,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.w),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextFormField(
              controller: controller2,
              obscureText: isPassword2,
              validator: validator2,
              keyboardType: keyboardType2,
              decoration: InputDecoration(
                labelText: hintText2,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildTripleTextField extends StatelessWidget {
  final String hintText1;
  final String hintText2;
  final String hintText3;
  final bool isPassword1;
  final bool isPassword2;
  final bool isPassword3;
  final TextEditingController? controller1;
  final TextEditingController? controller2;
  final TextEditingController? controller3;
  final String? Function(String?)? validator1;
  final String? Function(String?)? validator2;
  final String? Function(String?)? validator3;
  final TextInputType? keyboardType1;
  final TextInputType? keyboardType2;
  final TextInputType? keyboardType3;

  /// Flex values control how much space each field takes (default = 1)
  final int flex1;
  final int flex2;
  final int flex3;

  const BuildTripleTextField({
    super.key,
    required this.hintText1,
    required this.hintText2,
    required this.hintText3,
    this.isPassword1 = false,
    this.isPassword2 = false,
    this.isPassword3 = false,
    this.flex1 = 1,
    this.flex2 = 1,
    this.flex3 = 1,
    this.controller1,
    this.controller2,
    this.controller3,
    this.validator1,
    this.validator2,
    this.validator3,
    this.keyboardType1,
    this.keyboardType2,
    this.keyboardType3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            flex: flex1,
            child: TextFormField(
              controller: controller1,
              obscureText: isPassword1,
              validator: validator1,
              keyboardType: keyboardType1,
              decoration: InputDecoration(
                labelText: hintText1,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.w),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: flex2,
            child: TextFormField(
              controller: controller2,
              obscureText: isPassword2,
              validator: validator2,
              keyboardType: keyboardType2,
              decoration: InputDecoration(
                labelText: hintText2,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.w),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: flex3,
            child: TextFormField(
              controller: controller3,
              obscureText: isPassword3,
              validator: validator3,
              keyboardType: keyboardType3,
              decoration: InputDecoration(
                labelText: hintText3,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
