// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/api_service.dart';

class EditTask extends StatefulWidget {
  final ToDo todo;
  const EditTask({super.key, required this.todo});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  bool _isloading = false;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _title = widget.todo.title;
    _description = widget.todo.description;
  }

  Future<void> _updateTask() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });

      ToDo updatedTodo = ToDo(
          id: widget.todo.id,
          title: _title,
          description: _description,
          isCompleted: widget.todo.isCompleted);

          try {
            await apiService.updateTodo(updatedTodo);
            Navigator.pop(context, updatedTodo);
          } catch (error) {
            setState(() {
              _isloading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update task: $error')),);
          }
    }
  }

  Future<void> _deleteTask() async {
    setState(() {
      _isloading = true;
    });

    try {
      await apiService.deleteTodo(widget.todo.id);
      Navigator.pop(context, true);
    }
    catch(error) {
      setState(() {
        _isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete the task: $error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _isloading ? null : _deleteTask,
          ),
        ],
      ),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _title,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _title = value;
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: _description,
                      decoration: const InputDecoration(labelText: 'Description'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _description = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isloading ? null : _updateTask,
                      child: const Text('Update Task'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
