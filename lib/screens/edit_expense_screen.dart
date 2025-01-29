import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';

class EditExpenseScreen extends StatefulWidget {
  final String expenseId;

  EditExpenseScreen({required this.expenseId});

  @override
  _EditExpenseScreenState createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late String _category;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
    final expense = expenseProvider.getExpenseById(widget.expenseId);
    
    _descriptionController = TextEditingController(text: expense.description);
    _amountController = TextEditingController(text: expense.amount.toString());
    _category = expense.category;
    _date = expense.date;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(labelText: 'Category'),
                items: <String>['Food', 'Transport', 'Entertainment', 'Others']
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _category = value;
                    });
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final updatedExpense = Expense(
                      id: widget.expenseId,
                      description: _descriptionController.text,
                      amount: double.parse(_amountController.text),
                      category: _category,
                      date: _date,
                    );
                    expenseProvider.updateExpense(updatedExpense);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
