import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantist/view/login/signInPage.dart';
import 'package:plantist/view/register/signUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.document_scanner,
              size: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome back to',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const Text(
              'Plantist',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Start your productive life now!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Get.to(signInPage());
              },
              icon: const Icon(
                Icons.email,
                size: 25,
                color: Colors.black,
              ),
              label: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Text('Sign in with email',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
                onPressed: () => Get.to(SignUpPage()),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
