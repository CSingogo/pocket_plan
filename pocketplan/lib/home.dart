import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/todo_model.dart';
import 'package:flutter_to_do_app/screens/add_to_do.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/providers/todo_provider.dart';

const successSnackBar = SnackBar(
  content: Center(
    child: Text(
      'Contact Added',
      style: TextStyle(color: Colors.white, fontSize: 26),
    ),
  ),
);

const errorSnackBar = SnackBar(
  content: Center(
    child: Text(
      'Theres an Error',
      style: TextStyle(color: Colors.white, fontSize: 26),
    ),
  ),
);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    todoProvider.fetchTodos(); // Fetch ToDos when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    // Access the ColorScheme from the theme
    final colorScheme = Theme.of(context).colorScheme;
    List<Todo> toDosList = Provider.of<TodoProvider>(context).toDos;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('the pocket plan'),
      ),
      body: Column(
        children: [
          //const SizedBox(height: 600),
          Expanded(
            child: ListView.builder(
              itemCount: toDosList.length,
              itemBuilder: (context, index) {
                // Access the title of the Todo object correctly
                final todoTitle = toDosList[index].title;

                return ListTile(
                  title: Text(todoTitle),
                );
              },
            ),
          ),
          //const SizedBox(height: 5),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: FloatingActionButton.large(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddToDoForm()));
                      },
                      child: const Icon(Icons.add))))
        ],
      ),
    );
  }
}
