import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';
import 'package:uuid/uuid.dart';

class AddExpenseScreen extends StatelessWidget {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedCategory = 'Food';

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                selectedCategory = newValue!;
              },
              items: <String>['Food', 'Transport', 'Entertainment', 'Bills']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final description = descriptionController.text;
                final amount = double.tryParse(amountController.text) ?? 0.0;
                final String id = Uuid().v4(); // Generate a unique ID

                if (description.isNotEmpty && amount > 0) {
                  expenseProvider.addExpense(Expense(
                    id: id,
                    description: description,
                    amount: amount,
                    category: selectedCategory,
                    date: DateTime.now(),
                  ));
                  Navigator.pop(context);
                }
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
