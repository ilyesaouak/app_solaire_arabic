import 'package:flutter/material.dart';
import 'main_page.dart'; // Import the main_page.dart to navigate to MainPage

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> _questions = [
    {
      "question": "ما هو أكبر كوكب في النظام الشمسي؟",
      "answer": "المشتري",
      "options": ["المشتري", "المريخ", "الأرض"]
    },
    {
      "question": "ما هو الكوكب الأحمر؟",
      "answer": "المريخ",
      "options": ["المشتري", "المريخ", "زحل"]
    },
    {
      "question": "كم عدد الكواكب في النظام الشمسي؟",
      "answer": "8",
      "options": ["7", "8", "9"]
    },
    {
      "question": "ما هو الكوكب الأقرب إلى الشمس؟",
      "answer": "عطارد",
      "options": ["عطارد", "الزهرة", "المريخ"]
    },
    {
      "question": "أي كوكب له حلقات بارزة؟",
      "answer": "زحل",
      "options": ["المشتري", "زحل", "نبتون"]
    },
    {
      "question": "ما هو الكوكب الذي يحتوي على أعلى جبل؟",
      "answer": "المريخ",
      "options": ["المريخ", "الأرض", "الزهرة"]
    },
    {
      "question": "ما هو الكوكب الأزرق البعيد؟",
      "answer": "نبتون",
      "options": ["نبتون", "أورانوس", "المريخ"]
    },
    {
      "question": "كم يستغرق كوكب الأرض للدوران حول الشمس؟",
      "answer": "365 يوماً",
      "options": ["365 يوماً", "364 يوماً", "366 يوماً"]
    },
    {
      "question": "ما هو الكوكب المعروف بضغطه الجوي الهائل؟",
      "answer": "الزهرة",
      "options": ["الزهرة", "عطارد", "الأرض"]
    },
    {
      "question": "ما هو أصغر كوكب في النظام الشمسي؟",
      "answer": "عطارد",
      "options": ["عطارد", "المريخ", "نبتون"]
    },
  ];

  int _score = 0;
  int _currentQuestionIndex = 0;
  String _selectedAnswer = '';

  void _checkAnswer() {
    if (_selectedAnswer == _questions[_currentQuestionIndex]["answer"]) {
      _score++;
    }
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = ''; // Reset the selected answer
    });
  }

  void _resetQuiz() {
    setState(() {
      _score = 0;
      _currentQuestionIndex = 0;
      _selectedAnswer = ''; // Reset the selected answer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختبار النظام الشمسي')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentQuestionIndex < _questions.length
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _questions[_currentQuestionIndex]["question"],
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ..._questions[_currentQuestionIndex]["options"]
                        .map<Widget>((option) => Card(
                              color: _selectedAnswer == option
                                  ? Colors.blueAccent
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                title: Text(option),
                                onTap: () {
                                  setState(() {
                                    _selectedAnswer = option;
                                  });
                                },
                              ),
                            ))
                        .toList(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _selectedAnswer.isEmpty ? null : _checkAnswer,
                      child: const Text('التالي'),
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'نتيجتك: $_score / ${_questions.length}',
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _resetQuiz,
                      child: const Text('ابدأ من جديد'),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // 1 is for QuizPage
        onTap: (index) {
          if (index == 0) {
            // Navigate to the main page (Planet List)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          } else if (index == 1) {
            // Stay on the QuizPage
            // No action needed here since we're already on QuizPage
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
