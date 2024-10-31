import 'package:flutter/material.dart';
import 'package:flutter_to_do_app/providers/total_balance_provider.dart';
import 'package:flutter_to_do_app/screens/home.dart';
import 'package:flutter_to_do_app/providers/todo_provider.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(ChangeNotifierProvider(
//       create: (context) => TodoProvider(), child: const MyApp()));
// }

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(
            create: (context) => BalanceProvider()), // Add more providers here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
