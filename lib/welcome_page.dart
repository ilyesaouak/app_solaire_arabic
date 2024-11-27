import 'package:flutter/material.dart';
import 'main_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B1B2F), Color(0xFF162447)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Title
              const Text(
                'مرحبًا بك في النظام الشمسي',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.blueAccent,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // Space-themed image placeholder
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white38, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/space_icon.png', // Add this asset
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 50),
              // "Start Exploration" Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  side: const BorderSide(color: Colors.blueAccent, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5,
                  shadowColor: Colors.blueAccent.withOpacity(0.6),
                ),
                child: const Text(
                  'ابدأ الاستكشاف',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
