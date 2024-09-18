import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/screens/finance_page.dart';
import 'package:flutter_to_do_app/screens/home.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;

    // Define GlobalKey for navigator
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

    // Method to handle navigation on tap of BottomNavigationBarItem
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        _navigatorKey.currentState?.pushReplacementNamed('/task');
        break;
      case 1:
        _navigatorKey.currentState?.pushReplacementNamed('/treasure');
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Consistent BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Treasure',
          ),
        ],
      ),

      // Use Navigator for page transitions
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          Widget page;
          switch (settings.name) {
            case '/task':
              page = const HomePage();
              break;
            case '/treasure':
              page = FinancePage();
              break;
            default:
              page = HomePage();
          }
          return MaterialPageRoute(builder: (_) => page);
        },
      ),
    );
  }
}