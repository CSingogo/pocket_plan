import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// class TotalBalanceProvider with ChangeNotifier {
//   double _balance = 0;

//   double get balance => _balance;

//   Future<double> _fetchBalance() async {
//     final response = await http.get(Uri.parse('http://localhost:3000/balance'));
//     if (response.statusCode == 200) {
//       _balance = json.decode(response.body)['total'];
//       notifyListeners();
//     }
//     return _balance;
//   }
// }

class BalanceProvider with ChangeNotifier {
  double _balance = 0.0;

  Future<double> _fetchBalance() async {
    final response = await http.get(Uri.parse('http://localhost:3000/balance'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      _balance = _calculateTotal(jsonResponse);
      notifyListeners();
    } else {
      throw Exception('Failed to load balance');
    }

    return _balance;
  }

  double _calculateTotal(Map<String, dynamic> json) {
    // Navigate through the nested structure and sum the totals
    double total = 0;

    // Check if the top-level total exists and add it to the sum
    if (json.containsKey('total')) {
      total += json['total'] as double;
    }

    // Navigate to the nested 'item' structure
    if (json.containsKey('item')) {
      total += _traverseItems(json['item']);
    }

    return total;
  }

  double _traverseItems(Map<String, dynamic> item) {
    double sum = 0;

    // Check if the current item has a 'total' key
    if (item.containsKey('total')) {
      sum += item['total'] as double;
    }

    // Recursively check for further nested items
    if (item.containsKey('item')) {
      // The 'item' key can contain another item, so we need to recurse
      final nestedItem = item['item'] as Map<String, dynamic>;
      sum += _traverseItems(nestedItem);
    }

    return sum;
  }

  double get balance => _balance;
}
