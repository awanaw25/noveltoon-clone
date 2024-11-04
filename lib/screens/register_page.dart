import 'package:flutter/material.dart';
import '../auth_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Dashboard warna kuning di bagian atas
          Container(
            height: 150,
            color: Colors.yellow,
            alignment: Alignment.center,
            child: Text(
              'Register',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService().register(
                      emailController.text,
                      passwordController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Register'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Already have an account? Login here!'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
