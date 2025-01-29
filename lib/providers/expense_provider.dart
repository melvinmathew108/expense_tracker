import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  // Update an existing expense
  void updateExpense(Expense updatedExpense) {
    final index =
        _expenses.indexWhere((expense) => expense.id == updatedExpense.id);
    if (index != -1) {
      _expenses[index] = updatedExpense;
      notifyListeners();
    }
  }

  // Get an expense by ID
  Expense getExpenseById(String id) {
    return _expenses.firstWhere((expense) => expense.id == id);
  }

  double get totalExpenses {
    double total = 0;
    for (var expense in _expenses) {
      total += expense.amount;
    }
    return total;
  }

  double get totalIncome {
    double total = 0;
    for (var expense in _expenses) {
      if (expense.amount > 0) {
        total += expense.amount;
      }
    }
    return total;
  }

  List<Expense> getExpensesByCategory(String category) {
    return _expenses.where((e) => e.category == category).toList();
  }
}
