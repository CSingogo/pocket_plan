import 'package:flutter/material.dart';
import '../todo_list.dart';

class AddToDoForm extends StatefulWidget {
  const AddToDoForm({super.key});

  @override
  State<AddToDoForm> createState() => _AddToDoFormState();
}

class _AddToDoFormState extends State<AddToDoForm> {
  final TextEditingController _controller = TextEditingController();
  String _newToDo = '';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Use _controller and _newToDo here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add ToDo'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter new to-do',
              ),
              onChanged: (text) {
                setState(() {
                  _newToDo = text;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Handle adding the to-do item
                setState(() {
                  toDos.add(_newToDo);
                });
                Navigator.pop(context);
              },
              child: const Text('Add ToDo'),
            ),
          ],
        ),
      ),
    );
  }
}
