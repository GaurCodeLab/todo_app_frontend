import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')),
        );
      }

      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/register/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        print('Registration successful');
        Navigator.pushNamed(context, '/login');
      } else {
        if (mounted) {
          print('Registration failed');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Registration failed: ${response.statusCode}')),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        print('Error registering user : $error');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error registering user')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: const Text('Register'),
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'have an account?',
                  style: TextStyle( color: Colors.black),
                ),
                const SizedBox(width: 4.0),
                GestureDetector(
                    child: const Text(
                      'click here',
                      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    }),
                const Text(' to login',
                    style: TextStyle( color: Colors.black))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
