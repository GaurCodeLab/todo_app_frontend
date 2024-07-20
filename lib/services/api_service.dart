import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api/";

  Future<List<ToDo>> getToDos() async {
    final response = await http.get(Uri.parse('${baseUrl}todos/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((todo) => ToDo.fromJson(todo)).toList();
    } else {
      throw Exception('failed to load todos');
    }
  }

  Future<ToDo> createTodo(ToDo todo) async {
    final response = await http.post(
      Uri.parse('${baseUrl}todos/'),
      headers: {'Content-type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      return ToDo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Create todo');
    }
  }

  Future<ToDo> updateTodo(ToDo todo) async {
    final response = await http.put(
      Uri.parse('${baseUrl}todos/${todo.id}/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      return ToDo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}todos/$id/'),
    );
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
