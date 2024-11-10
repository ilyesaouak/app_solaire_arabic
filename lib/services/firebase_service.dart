import 'package:firebase_database/firebase_database.dart'; // Import for Firebase Realtime Database
import '../models/planet.dart'; // Make sure the Planet model is correctly imported

class FirebaseService {
  final DatabaseReference planetsReference = FirebaseDatabase.instance
      .ref('planets'); // Reference to 'planets' in your Firebase Database

  // Method to fetch planets from Firebase Realtime Database
  Future<List<Planet>> fetchPlanets() async {
    try {
      DatabaseEvent event =
          await planetsReference.once(); // Fetch the data once
      DataSnapshot snapshot = event.snapshot; // Get the snapshot of the data
      if (snapshot.exists) {
        Map<dynamic, dynamic> planetsMap =
            snapshot.value as Map<dynamic, dynamic>; // Cast the value to Map
        return planetsMap.entries.map((entry) {
          return Planet.fromMap(
              entry.value); // Convert each entry into a Planet
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching planets: $e');
      return [];
    }
  }
}
