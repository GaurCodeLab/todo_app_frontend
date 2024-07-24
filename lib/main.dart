import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_main_screen.dart';
import 'package:todo_app/utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My ToDo',
      theme: appTheme,
      home: const TodoListScreen(),
    );
  }
}
