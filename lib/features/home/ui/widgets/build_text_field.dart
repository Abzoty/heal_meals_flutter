import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String hintText;
  final bool isPassword;

  const BuildTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: hintText,
          border: const UnderlineInputBorder(),
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

  const BuildDoubleTextField({
    super.key,
    required this.hintText1,
    required this.hintText2,
    this.isPassword1 = false,
    this.isPassword2 = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: isPassword1,
              decoration: InputDecoration(
                labelText: hintText1,
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              obscureText: isPassword2,
              decoration: InputDecoration(
                labelText: hintText2,
                border: const UnderlineInputBorder(),
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
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: flex1,
            child: TextField(
              obscureText: isPassword1,
              decoration: InputDecoration(
                labelText: hintText1,
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: flex2,
            child: TextField(
              obscureText: isPassword2,
              decoration: InputDecoration(
                labelText: hintText2,
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: flex3,
            child: TextField(
              obscureText: isPassword3,
              decoration: InputDecoration(
                labelText: hintText3,
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

