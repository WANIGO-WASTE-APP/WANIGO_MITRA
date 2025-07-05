import 'package:flutter/material.dart';
import 'package:wanigo_mitra/features/auth/views/landing_screen.dart';
import 'dart:async'; // Untuk delay

// Halaman SplashScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Menunggu 5-7 detik, lalu pindah ke halaman login
    Timer(const Duration(seconds: 2), () {
      // Arahkan ke LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          opacity: 1.0, // Animasi opacity untuk fade-in
          duration: const Duration(seconds: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Image.asset(
                'assets/wanigo.png', 
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(), // Animasi loading
            ],
          ),
        ),
      ),
    );
  }
}


