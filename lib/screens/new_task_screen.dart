//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import '../services/api_service.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  bool _isCompleted = false;
  DateTime? _dueDate;

  final ApiService apiService = ApiService();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ToDo newTodo = ToDo(
        id: 0, // The backend will assign the correct ID
        title: _title,
        description: _description,
        isCompleted: _isCompleted,
        dueDate: _dueDate,
      );

      apiService.createTodo(newTodo).then((createdTodo) {
        Navigator.pop(context, createdTodo);
      }).catchError((error) {
        if (error is! Exception ||
            error.toString() != 'Failed to Create todo') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to create todo: $error')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) => _description = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              SwitchListTile(
                title: const Text('Completed'),
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value;
                  });
                },
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      initialDate: DateTime.now());
                  if (pickedDate != null) {
                    setState(() {
                      _dueDate = pickedDate;
                    });
                  }
                },
                child: const Text('Select Due Date'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
