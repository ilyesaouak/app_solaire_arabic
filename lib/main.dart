import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main_page.dart'; // Import MainPage
import 'quiz_page.dart'; // Import QuizPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const SolarSystemApp());
}

class SolarSystemApp extends StatefulWidget {
  const SolarSystemApp({super.key});

  @override
  _SolarSystemAppState createState() => _SolarSystemAppState();
}

class _SolarSystemAppState extends State<SolarSystemApp> {
  // Index for bottom navigation bar
  int _selectedIndex = 0;

  // List of pages to navigate between
  final List<Widget> _pages = [
    const MainPage(), // Page with planet list
    const QuizPage(), // Quiz page
  ];

  // Handle page selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'النظام الشمسي',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF1B1B2F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B1B2F),
          elevation: 0,
          centerTitle: true,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('النظام الشمسي'),
          centerTitle: true,
        ),
        body: _pages[_selectedIndex], // Display selected page
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'الأنظمة',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.quiz),
              label: 'الاختبار',
            ),
          ],
        ),
      ),
    );
  }
}
