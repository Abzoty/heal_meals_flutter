import "package:flutter/material.dart";
import "package:heal_meals/core/routing/routes.dart";

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  static const routeName = '/start-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3DB766),
              Color(0xFF2D995D),
              Color(0xFF1C7C54),
              Color(0xFF1B512D),  
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/heal_meals.png",
                width: 400,
                height: 400,
              ),
              Text(
                "Heal Meals",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Eat Well, Live Better",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 80),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the sign-up screen
                    Navigator.pushNamed(context, AppRoutes.signup);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B512D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    animationDuration: const Duration(milliseconds: 200),
                    elevation: 1,
                  ),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
