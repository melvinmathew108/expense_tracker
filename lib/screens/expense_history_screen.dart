import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import 'edit_expense_screen.dart'; // Import the EditExpenseScreen

class ExpenseHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expenseProvider.expenses;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expense History'),
      ),
      body: expenses.isEmpty
          ? Center(child: Text('No expenses added yet.'))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return ListTile(
                  title: Text(expense.description),
                  subtitle: Text('${expense.amount} USD - ${expense.category}'),
                  trailing: Text(expense.date.toString().substring(0, 10)),
                  onTap: () {
                    // Navigate to the Edit Expense screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditExpenseScreen(expenseId: expense.id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
