// import 'package:flutter/material.dart';

// class FinancePage extends StatefulWidget {
//   const FinancePage({super.key});

//   @override
//   State<FinancePage> createState() => _FinancePageState();
// }

// class _FinancePageState extends State<FinancePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: const Center(child: Text('finance app')),
//     );
//   }
// }

// ------>

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fl_chart/fl_chart.dart';

// class FinancePage extends StatefulWidget {
//   const FinancePage({super.key});

//   @override
//   State<FinancePage> createState() => _FinancePageState();
// }

// class _FinancePageState extends State<FinancePage> {
//   double _totalBalance = 0;
//   List<Map<String, dynamic>> _transactions = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchBalance();
//     _fetchTransactions();
//   }

//   Future<void> _fetchBalance() async {
//     final response = await http.get(Uri.parse('http://localhost:3000/balance'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _totalBalance = json.decode(response.body)['total'];
//       });
//     }
//   }

//   Future<void> _fetchTransactions() async {
//     final response =
//         await http.get(Uri.parse('http://localhost:3000/transactions'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _transactions =
//             List<Map<String, dynamic>>.from(json.decode(response.body));
//       });
//     }
//   }

//   Future<void> _addTransaction(
//       String type, double amount, String description) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:3000/transactions'),
//       headers: {'Content-Type': 'application/json'},
//       body: json
//           .encode({'type': type, 'amount': amount, 'description': description}),
//     );
//     if (response.statusCode == 201) {
//       setState(() {
//         _transactions
//             .add({'type': type, 'amount': amount, 'description': description});
//         _totalBalance += (type == 'income' ? amount : -amount);
//       });
//       await http.patch(
//         Uri.parse('http://localhost:3000/balance'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'total': _totalBalance}),
//       );
//     }
//   }

//   void _showTransactionForm() {
//     final descriptionController = TextEditingController();
//     final amountController = TextEditingController();
//     String type = 'income';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Add Transaction"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: amountController,
//                 decoration: const InputDecoration(labelText: 'Amount'),
//                 keyboardType: TextInputType.number,
//               ),
//               DropdownButton<String>(
//                 value: type,
//                 onChanged: (value) {
//                   setState(() {
//                     type = value!;
//                   });
//                 },
//                 items: const [
//                   DropdownMenuItem(value: 'income', child: Text('Income')),
//                   DropdownMenuItem(value: 'expense', child: Text('Expense')),
//                 ],
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 final amount = double.tryParse(amountController.text) ?? 0;
//                 final description = descriptionController.text;
//                 if (description.isNotEmpty && amount > 0) {
//                   _addTransaction(type, amount, description);
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: const Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double income = _transactions
//         .where((t) => t['type'] == 'income')
//         .fold(0, (sum, item) => sum + item['amount']);
//     double expenses = _transactions
//         .where((t) => t['type'] == 'expense')
//         .fold(0, (sum, item) => sum + item['amount']);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Finance Tracker')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Total Balance: \$$_totalBalance',
//                 style: Theme.of(context).textTheme.headlineSmall),
//             const SizedBox(height: 16),
//             Expanded(
//               child: PieChart(PieChartData(
//                 sections: [
//                   PieChartSectionData(
//                       value: income, color: Colors.green, title: 'Income'),
//                   PieChartSectionData(
//                       value: expenses, color: Colors.red, title: 'Expenses'),
//                 ],
//               )),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _transactions.length,
//                 itemBuilder: (context, index) {
//                   final transaction = _transactions[index];
//                   return ListTile(
//                     title: Text(transaction['description']),
//                     subtitle: Text(transaction['type']),
//                     trailing: Text('\$${transaction['amount']}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showTransactionForm,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fl_chart/fl_chart.dart';

// class FinancePage extends StatefulWidget {
//   const FinancePage({super.key});

//   @override
//   State<FinancePage> createState() => _FinancePageState();
// }

// class _FinancePageState extends State<FinancePage> {
//   double _totalBalance = 0;
//   List<Map<String, dynamic>> _transactions = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchBalance();
//     _fetchTransactions();
//   }

//   Future<void> _fetchBalance() async {
//     final response = await http.get(Uri.parse('http://localhost:3000/balance'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _totalBalance = json.decode(response.body)['total'];
//       });
//     }
//   }

//   Future<void> _fetchTransactions() async {
//     final response =
//         await http.get(Uri.parse('http://localhost:3000/transactions'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _transactions =
//             List<Map<String, dynamic>>.from(json.decode(response.body));
//       });
//     }
//   }

//   Future<void> _addTransaction(
//       String type, double amount, String description) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:3000/transactions'),
//       headers: {'Content-Type': 'application/json'},
//       body: json
//           .encode({'type': type, 'amount': amount, 'description': description}),
//     );
//     if (response.statusCode == 201) {
//       setState(() {
//         _transactions
//             .add({'type': type, 'amount': amount, 'description': description});
//         _totalBalance += (type == 'income' ? amount : -amount);
//       });
//       await http.patch(
//         Uri.parse('http://localhost:3000/balance'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'total': _totalBalance}),
//       );
//     }
//   }

//   Future<void> _deleteTransaction(int index, int transactionId) async {
//     final response = await http.delete(
//       Uri.parse('http://localhost:3000/transactions/$transactionId'),
//     );
//     if (response.statusCode == 200) {
//       setState(() {
//         final transaction = _transactions[index];
//         _totalBalance -= (transaction['type'] == 'income'
//             ? transaction['amount']
//             : -transaction['amount']);
//         _transactions.removeAt(index);
//       });
//       await http.patch(
//         Uri.parse('http://localhost:3000/balance'),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'total': _totalBalance}),
//       );
//     }
//   }

//   void _showDeleteConfirmation(int index, int transactionId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Delete Transaction"),
//           content:
//               const Text("Are you sure you want to delete this transaction?"),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 _deleteTransaction(index, transactionId);
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showTransactionForm() {
//     final descriptionController = TextEditingController();
//     final amountController = TextEditingController();
//     String type = 'income';

//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Add Transaction"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: descriptionController,
//                 decoration: const InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: amountController,
//                 decoration: const InputDecoration(labelText: 'Amount'),
//                 keyboardType: TextInputType.number,
//               ),
//               DropdownButton<String>(
//                 value: type,
//                 onChanged: (value) {
//                   setState(() {
//                     type = value!;
//                   });
//                 },
//                 items: const [
//                   DropdownMenuItem(value: 'income', child: Text('Income')),
//                   DropdownMenuItem(value: 'expense', child: Text('Expense')),
//                 ],
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () {
//                 final amount = double.tryParse(amountController.text) ?? 0;
//                 final description = descriptionController.text;
//                 if (description.isNotEmpty && amount > 0) {
//                   _addTransaction(type, amount, description);
//                   Navigator.of(context).pop();
//                 }
//               },
//               child: const Text("Add"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double income = _transactions
//         .where((t) => t['type'] == 'income')
//         .fold(0, (sum, item) => sum + item['amount']);
//     double expenses = _transactions
//         .where((t) => t['type'] == 'expense')
//         .fold(0, (sum, item) => sum + item['amount']);

//     return Scaffold(
//       appBar: AppBar(title: const Text('Finance Tracker')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Total Balance: \$$_totalBalance',
//                 style: Theme.of(context).textTheme.headlineSmall),
//             const SizedBox(height: 16),
//             Expanded(
//               child: PieChart(PieChartData(
//                 sections: [
//                   PieChartSectionData(
//                       value: income, color: Colors.green, title: 'Income'),
//                   PieChartSectionData(
//                       value: expenses, color: Colors.red, title: 'Expenses'),
//                 ],
//               )),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _transactions.length,
//                 itemBuilder: (context, index) {
//                   final transaction = _transactions[index];
//                   return GestureDetector(
//                     onLongPress: () =>
//                         _showDeleteConfirmation(index, transaction['id']),
//                     child: ListTile(
//                       title: Text(transaction['description']),
//                       subtitle: Text(transaction['type']),
//                       trailing: Text('\$${transaction['amount']}'),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showTransactionForm,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

//--------------------------- --------------- >>

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_to_do_app/providers/total_balance_provider.dart';
import 'package:provider/provider.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  List<Map<String, dynamic>> _transactions = [];
  late double _totalBalance;

  @override
  void initState() {
    super.initState();
    _fetchBalance();
    _fetchTransactions();
    _totalBalance =
        Provider.of<BalanceProvider>(context, listen: false).balance;
  }

  Future<void> _fetchBalance() async {
    final response = await http.get(Uri.parse('http://localhost:3000/balance'));
    if (response.statusCode == 200) {
      setState(() {
        _totalBalance = json.decode(response.body)['total'];
      });
    }
  }

  Future<void> _fetchTransactions() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/transactions'));
    if (response.statusCode == 200) {
      setState(() {
        _transactions =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    }
  }

  Future<void> _addTransaction(
      String type, double amount, String description) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/transactions'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'type': type, 'amount': amount, 'description': description}),
    );
    if (response.statusCode == 201) {
      setState(() {
        _transactions
            .add({'type': type, 'amount': amount, 'description': description});
        _totalBalance += (type == 'income' ? amount : -amount);
      });
      await http.patch(
        Uri.parse('http://localhost:3000/balance'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'total': _totalBalance}),
      );
    }
  }

  void _showTransactionForm(String type) {
    final descriptionController = TextEditingController();
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Transaction"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0;
                final description = descriptionController.text;
                if (description.isNotEmpty && amount > 0) {
                  _addTransaction(type, amount, description);
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double income = _transactions
        .where((t) => t['type'] == 'income')
        .fold(0, (sum, item) => sum + item['amount']);
    double expenses = _transactions
        .where((t) => t['type'] == 'expense')
        .fold(0, (sum, item) => sum + item['amount']);

    return Scaffold(
      appBar: AppBar(title: const Text('Finance Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Balance: \$${_totalBalance.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 16),
            Expanded(
              child: PieChart(PieChartData(
                sections: [
                  PieChartSectionData(
                      value: income, color: Colors.green, title: 'Income'),
                  PieChartSectionData(
                      value: expenses, color: Colors.red, title: 'Expenses'),
                ],
              )),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showTransactionForm('income'),
                  child: const Text("Add Income"),
                ),
                ElevatedButton(
                  onPressed: () => _showTransactionForm('expense'),
                  child: const Text("Add Expense"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
