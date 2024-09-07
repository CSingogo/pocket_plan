import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  final List<String> _toDos = ['eat', 'sleep', 'code'];

  List<String> get toDos => _toDos;

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

  void addToDo(String x) {
    _toDos.add(x);
    notifyListeners();
  }
}
