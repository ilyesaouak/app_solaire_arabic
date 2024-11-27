import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'planet_details_page.dart';
import 'quiz_page.dart'; // Import the quiz page
import 'login_page.dart'; // Import the login page

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1B2F),
        elevation: 0,
        title: const Text(
          'الكواكب',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              try {
                // Log out the user
                await FirebaseAuth.instance.signOut();
                // Redirect to the Login page after logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } catch (e) {
                // Handle logout error
                print("Logout failed: $e");
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1B1B2F), Color(0xFF162447)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('planets').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              );
            }

            final planets = snapshot.data!.docs;
            return ListView.builder(
              itemCount: planets.length,
              itemBuilder: (context, index) {
                final planet = planets[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    color: Colors.black.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          planet['image_url'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        planet['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        planet['description'],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueAccent,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PlanetDetailsPage(planet: planet),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // 0 is for MainPage
        onTap: (index) {
          if (index == 0) {
            // Stay on the MainPage
            // No action needed since we're already on MainPage
          } else if (index == 1) {
            // Navigate to the QuizPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const QuizPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'الكواكب',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'الاختبار',
          ),
        ],
      ),
    );
  }
}
