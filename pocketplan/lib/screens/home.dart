import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/models/todo_model.dart';
import 'package:flutter_to_do_app/screens/add_to_do.dart';
import 'package:flutter_to_do_app/screens/finance_page.dart';
import 'package:flutter_to_do_app/screens/task_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_to_do_app/providers/todo_provider.dart';
import 'package:flutter/cupertino.dart';

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

  // bottom navigation bar pages
  final List<Widget> _pages = [
    const TaskPage(),
    const FinancePage(),
  ];

// index variable for bottom page navigation
  int _currentIndex = 0;

//method to switch bottom mavigation tabs
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: const Text(' Task + Treasure',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2)),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[700],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.white,
              size: 50,
            ),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.lock, color: Colors.white, size: 50),
            label: 'Treasure',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
