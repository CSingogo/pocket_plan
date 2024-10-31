import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/todo_model.dart';
import 'package:flutter_to_do_app/providers/todo_provider.dart';
import 'package:flutter_to_do_app/screens/add_to_do.dart';
import 'package:provider/provider.dart';

const successSnackBar = SnackBar(
  content: Center(
    child: Text(
      'To-Do Added',
      style: TextStyle(color: Colors.white, fontSize: 26),
    ),
  ),
);

const successSnackBarDelete = SnackBar(
  content: Center(
    child: Text(
      'To Do Deleted',
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

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
    // Fetch todos when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      todoProvider.fetchTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Consumer<TodoProvider>(
          builder: (context, todoProvider, child) {
            List<Todo> toDosList = todoProvider.toDos;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: toDosList.length,
                    itemBuilder: (context, index) {
                      final todoTitle = toDosList[index].title;

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        color: Colors.grey.shade700,
                        child: ListTile(
                          title: Text(todoTitle),
                          titleTextStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 1),
                          onLongPress: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height: 100,
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Handle cancel action
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors
                                                  .grey[700] // Background color
                                              ),
                                          child: const Text(
                                            'Cancel',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            // Handle delete action
                                            final todoId = toDosList[index].id;
                                            final response = await todoProvider
                                                .deleteTodo(todoId);
                                            if (response.statusCode == 200) {
                                              if (mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        successSnackBarDelete);
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(errorSnackBar);
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(255, 162,
                                                    95, 90), // Background color
                                          ),
                                          child: const Text('Delete',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255))),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0, right: 10),
                    child: FloatingActionButton.large(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddToDoForm(),
                          ),
                        );
                      },
                      backgroundColor: Colors.grey[700],
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
