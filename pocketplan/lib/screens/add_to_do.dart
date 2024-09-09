import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/providers/todo_provider.dart';

class AddToDoForm extends StatefulWidget {
  const AddToDoForm({super.key});

  @override
  State<AddToDoForm> createState() => _AddToDoFormState();
}

class _AddToDoFormState extends State<AddToDoForm> {
  final TextEditingController _controller = TextEditingController();

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
            ),
            ElevatedButton(
                onPressed: () {
                  final newTodoTitle = _controller.text.trim();
                  if (newTodoTitle.isNotEmpty) {
                    final newTodo = Todo(
                      id: DateTime.now()
                          .millisecondsSinceEpoch
                          .toInt(), // Generate a unique ID
                      title: newTodoTitle,
                      completed: false, // Default value
                    );

                    Provider.of<TodoProvider>(context, listen: false)
                        .addToDo(newTodo);
                    // Clear the input field
                    _controller.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('To-Do Added'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add ToDo')),
          ],
        ),
      ),
    );
  }
}
