import 'package:flutter/material.dart';
import 'package:plantist/controller/auth/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70),
            Text(
              'Sign up with email',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Enter your email and password',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 70),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {

                AuthController.instance.register(emailController.text.trim(),passwordController.text.trim());
                
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[500],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Container(
                  alignment: Alignment.center,
                  width: 200, // Make button take full width
                  padding: EdgeInsets.symmetric(
                      vertical: 16), // Adjust vertical padding
                  child: const Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      // Increase font size if needed
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  
}
