// import 'package:flutter/material.dart';
// import 'package:flutter_to_do_app/models/todo_model.dart';
// import 'package:flutter_to_do_app/screens/add_to_do.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_to_do_app/providers/todo_provider.dart';

// const successSnackBar = SnackBar(
//   content: Center(
//     child: Text(
//       'Contact Added',
//       style: TextStyle(color: Colors.white, fontSize: 26),
//     ),
//   ),
// );

// const errorSnackBar = SnackBar(
//   content: Center(
//     child: Text(
//       'Theres an Error',
//       style: TextStyle(color: Colors.white, fontSize: 26),
//     ),
//   ),
// );

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch todos when the widget is initialized
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final todoProvider = Provider.of<TodoProvider>(context, listen: false);
//       todoProvider.fetchTodos();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Access the ColorScheme from the theme
//     final colorScheme = Theme.of(context).colorScheme;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: colorScheme.inversePrimary,
//         title: const Text('the pocket plan'),
//       ),
//       body: Consumer<TodoProvider>(
//         builder: (context, todoProvider, child) {
//           List<Todo> toDosList = todoProvider.toDos;

//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: toDosList.length,
//                   itemBuilder: (context, index) {
//                     final todoTitle = toDosList[index].title;

//                     return ListTile(
//                       title: Text(todoTitle),
//                       onLongPress: () {
//                         showModalBottomSheet<void>(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return Container(
//                               height: 100,
//                               color: Colors.white,
//                               child: Row(
//                                 children: [
//                                   Center(
//                                     child: ElevatedButton(
//                                       child: const Text('Delete to do?'),
//                                       onPressed: () => Navigator.pop(context),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 100.0, right: 30),
//                   child: FloatingActionButton.large(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const AddToDoForm(),
//                         ),
//                       );
//                     },
//                     child: const Icon(Icons.add),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/todo_model.dart';
import 'package:flutter_to_do_app/screens/add_to_do.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/providers/todo_provider.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    // Access the ColorScheme from the theme
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('the pocket plan'),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          List<Todo> toDosList = todoProvider.toDos;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: toDosList.length,
                  itemBuilder: (context, index) {
                    final todoTitle = toDosList[index].title;

                    return ListTile(
                      title: Text(todoTitle),
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
                                        backgroundColor: const Color.fromARGB(
                                            255,
                                            83,
                                            73,
                                            73), // Background color
                                      ),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
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
                                                .showSnackBar(successSnackBarDelete);
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(errorSnackBar);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255,
                                            162,
                                            95,
                                            90), // Background color
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
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100.0, right: 30),
                  child: FloatingActionButton.large(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddToDoForm(),
                        ),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
