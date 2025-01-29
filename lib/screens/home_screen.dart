import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import 'add_expense_screen.dart';
import 'expense_history_screen.dart'; // Import the new history screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Expenses: \$${expenseProvider.totalExpenses.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Total Income: \$${expenseProvider.totalIncome.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddExpenseScreen(),
                  ),
                );
              },
              child: Text('Add Expense'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpenseHistoryScreen(),
                  ),
                );
              },
              child: Text('View Expense History'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddExpenseScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
