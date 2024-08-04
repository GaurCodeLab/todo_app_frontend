
//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_main_screen.dart';
//import 'package:http/http.dart' as http;
import 'package:todo_app/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  Future<void> _loginUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please fill in all fields')));
      }
      return;
    }
    try {
      await apiService.login(email, password);

      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TodoListScreen()));
      }

      // final response =
      //     await http.post(Uri.parse('http://127.0.0.1:8000/api/token/'),
      //         headers: {'Content-Type': 'application/json'},
      //         body: json.encode({
      //           "email": email,
      //           "password": password,
      //         }));
      // if (response.statusCode == 200) {
      //   print('login succeccful');
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const TodoListScreen()),
      //   );
      // } else {
      //   if (mounted) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('Login Failed: ${response.statusCode}')));
      //   }
      // }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Error logging in')));
      }
      print('Error logging in : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginUser,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
