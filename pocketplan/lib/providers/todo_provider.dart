import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodoProvider with ChangeNotifier {
  List<Todo> _toDos = [];

  List<Todo> get toDos => _toDos;

  final successSnackBar = const SnackBar(
    content: Center(
      child: Text(
        'Contact Added',
        style: TextStyle(color: Colors.white, fontSize: 26),
      ),
    ),
  );

  final errorSnackBar = const SnackBar(
    content: Center(
      child: Text(
        'Theres an Error',
        style: TextStyle(color: Colors.white, fontSize: 26),
      ),
    ),
  );

  //fetch logic for todos
  Future<void> fetchTodos() async {
    final response = await http.get(Uri.parse('http://localhost:3000/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchedData = json.decode(response.body);
      _toDos = fetchedData.map((data) => Todo.fromJson(data)).toList();
     
      notifyListeners();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

  //POST logic for todos
  Future<http.Response> createTodo(BuildContext context, Todo todo) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/todos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(todo.toJson()),
    );
    fetchTodos();

    return response;
  }

  // DELETE logic for todos
  Future<http.Response> deleteTodo(String id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/todos/$id'),
       headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    );
    fetchTodos();
    return response;
  }


}
