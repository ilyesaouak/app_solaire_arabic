import 'package:flutter/material.dart';
import 'package:solar_system_arabic/screens/planet_detail_screen.dart';
import 'package:solar_system_arabic/services/firebase_service.dart'; // Ensure this is the correct path to your service
import '../models/planet.dart'; // Ensure the correct import path to your model

class HomeScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solar System - Arabic'),
      ),
      body: FutureBuilder<List<Planet>>(
        future: firebaseService.fetchPlanets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No planets available.'));
          } else {
            List<Planet> planets = snapshot.data!;
            return ListView.builder(
              itemCount: planets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(planets[index].name),
                  subtitle: Text(planets[index].description),
                  onTap: () {
                    // Navigate to the detail screen when tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PlanetDetailScreen(planet: planets[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
