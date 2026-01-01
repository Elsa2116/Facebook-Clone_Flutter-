import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';
import 'home_screen.dart';

/// SplashScreen
/// Shows Facebook splash for 3 seconds
/// Then decides where to go based on Firebase auth state
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait for 3 seconds before navigating
    Timer(const Duration(seconds: 3), () {
      // Check if a user is already logged in
      if (FirebaseAuth.instance.currentUser != null) {
        // User is logged in → go to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        // No user → go to LoginScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// Centered splash content
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Facebook logo circle
            Container(
              width: 140,
              height: 140,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  "f",
                  style: TextStyle(
                    fontSize: 110,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Arial",
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            /// App title text
            const Text(
              "Facebook",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
