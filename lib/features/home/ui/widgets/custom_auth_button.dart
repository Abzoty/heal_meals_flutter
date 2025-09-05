import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CustomAuthButton({
    super.key,
    required this.buttonText,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1B512D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
    );
  }
}
