import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_page.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showToast('لا يوجد حساب بهذا البريد الإلكتروني');
      } else if (e.code == 'wrong-password') {
        _showToast('كلمة المرور غير صحيحة');
      } else if (e.code == 'invalid-email') {
        _showToast('البريد الإلكتروني غير صالح');
      } else if (e.code == 'network-request-failed') {
        _showToast('خطأ في الشبكة. تحقق من اتصالك بالإنترنت.');
      } else {
        _showToast('حدث خطأ غير متوقع: ${e.message}');
      }
    } catch (e) {
      _showToast('حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.');
      print(e); // Debugging: Print the error
    }
  }

  void _resetPassword() async {
    if (_emailController.text.trim().isEmpty) {
      _showToast('يرجى إدخال البريد الإلكتروني');
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      _showToast('تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showToast('لا يوجد حساب بهذا البريد الإلكتروني');
      } else if (e.code == 'network-request-failed') {
        _showToast('خطأ في الشبكة. تحقق من اتصالك بالإنترنت.');
      } else {
        _showToast('حدث خطأ أثناء إعادة تعيين كلمة المرور: ${e.message}');
      }
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('تسجيل الدخول'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _resetPassword,
              child: const Text(
                'هل نسيت كلمة المرور؟',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('إنشاء حساب جديد'),
            ),
          ],
        ),
      ),
    );
  }
}
