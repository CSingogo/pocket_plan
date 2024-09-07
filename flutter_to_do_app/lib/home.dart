import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/screens/add_to_do.dart';
import './todo_list.dart';

const snackBar = SnackBar(
  content: Center(
    child: Text(
      'Contact Added',
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
  Widget build(BuildContext context) {
    // Access the ColorScheme from the theme
    final colorScheme = Theme.of(context).colorScheme;

    void addToDo(String item) {
      setState(() {
        toDos.add(item);
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('to do app flutter'),
      ),
      body: Column(
        children: [
          //const SizedBox(height: 600),
          Expanded(
            child: ListView.builder(
              itemCount: toDos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(toDos[index]),
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
