// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/edit_task_screen.dart';
import 'package:todo_app/screens/new_task_screen.dart';
import '../services/api_service.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Future<List<ToDo>> futureTodos;
  final ApiService apiService = ApiService();
  List<ToDo> _todos = [];

  void _loadTodos() {
    apiService.getToDos().then((todos) {
      setState(() {
        _todos = todos;
      });
    }).catchError((error) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load todos: $error')),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    // futureTodos = apiService.getToDos();
    _loadTodos();
  }

  void _deleteTodo(ToDo todo) {
    apiService.deleteTodo(todo.id).then((_) {
      setState(() {
        _todos.remove(todo);
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delte task: $error')),
      );
    });
  }

  void _editTodo(ToDo todo) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTask(todo: todo)),
    );
    if (result != null) {
      if (result is bool && result) {
        _loadTodos();
      } else if (result is ToDo) {
        setState(() {
          final index = _todos.indexWhere((test) => test.id == result.id);
          if (index != -1) {
            _todos[index] = result;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: _todos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                ToDo todo = _todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                          value: todo.isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              todo.isCompleted = value!;
                              apiService.updateTodo(todo);
                            });
                          }),
                      IconButton(
                        onPressed: () {
                          _editTodo(todo);
                        },
                        icon: Icon(Icons.edit),
                      )
                    ],
                  ),
                  onTap: () {
                    _editTodo(todo);
                  },
                );
              },
            ),

      //  FutureBuilder<List<ToDo>>(
      //   future: futureTodos,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      //       return const Center(child: Text('No todos available'));
      //     } else {
      //       return ListView.builder(
      //         itemCount: snapshot.data!.length,
      //         itemBuilder: (context, index) {
      //           ToDo todo = snapshot.data![index];
      //           return ListTile(
      //             title: Text(todo.title),
      //             subtitle: Text(todo.description),
      //             trailing: Checkbox(
      //               value: todo.isCompleted,
      //               onChanged: (bool? value) {
      //                 setState(() {
      //                   todo.isCompleted = value!;
      //                   apiService.updateTodo(todo);
      //                 });
      //               },
      //             ),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTodoScreen()),
          );
          if (result != null && result is ToDo) {
            setState(() {
              _todos.add(result);
            });
          }
          // Navigate to a screen to create a new todo (will be implemented later)
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
