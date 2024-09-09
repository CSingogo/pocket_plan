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

  void addToDo(Todo todo) {
    _toDos.add(todo);
    notifyListeners();
  }

  //fetch logic for todos
  Future<void> fetchTodos() async {
    final response = await http.get(Uri.parse('http://localhost:3000/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchedData = json.decode(response.body);
      _toDos = fetchedData.map((data) => Todo.fromJson(data)).toList();
      print('Fetched todos : $_toDos');
      notifyListeners();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }

    //POST logic for todos
  Future<void> postTodo() async {
    final response = await http.get(Uri.parse('http://localhost:3000/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> fetchedData = json.decode(response.body);
      _toDos = fetchedData.map((data) => Todo.fromJson(data)).toList();
      print('Fetched todos : $_toDos');
      notifyListeners();
    } else {
      throw Exception('Failed to fetch todos');
    }
  }
}
