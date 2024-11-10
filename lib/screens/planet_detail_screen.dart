import 'package:flutter/material.dart';
import '../models/planet.dart'; // Ensure the correct import path to your model

class PlanetDetailScreen extends StatelessWidget {
  final Planet planet;

  PlanetDetailScreen({required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(planet.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image using Image.network
            Image.network(planet.image), // Use the image field here
            SizedBox(height: 20),
            Text(planet.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(planet.description),
          ],
        ),
      ),
    );
  }
}
