import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/token_service.dart';

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api/";
  String token = '';

  Future<void> login(String email, String password) async {
    final response = await http.post(Uri.parse('${baseUrl}token/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      token = jsonData['access'];
      final exp = jsonData['exp'];
      // print('token :$token');

      if (exp != null) {
        await TokenService.storeToken(token, exp);
      } else {
        await TokenService.storeToken(
            token, DateTime.now().millisecondsSinceEpoch + 3600000);
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<ToDo>> getToDos() async {
    final token = await TokenService.getToken();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    // print('Headers : $headers');
    final response = await http.get(
      Uri.parse('${baseUrl}todos/'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      // print(response.body);
      List jsonResponse = json.decode(response.body);

      return jsonResponse.map((todo) => ToDo.fromJson(todo)).toList();
    } else {
      throw Exception('failed to load todos');
    }
  }

  Future<ToDo> createTodo(ToDo todo) async {
    final token = await TokenService.getToken();

    final response = await http.post(
      Uri.parse('${baseUrl}todos/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      return ToDo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Create todo');
    }
  }

  Future<ToDo> updateTodo(ToDo todo) async {
    final token = await TokenService.getToken();
    final response = await http.put(
      Uri.parse('${baseUrl}todos/${todo.id}/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      return ToDo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(int id) async {
    final token = await TokenService.getToken();
    final response = await http.delete(
      Uri.parse('${baseUrl}todos/$id/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
