import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/expenses%20list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses,required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        //adding Dismissible widget for removing the expense by swiping
        itemBuilder: (context, index) =>Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              margin: Theme.of(context).cardTheme.margin,
            ),
            onDismissed: (direction){
              onRemoveExpense(expenses[index]);
            } ,// here we can swip left or right both
            key: ValueKey(expenses[index]),//this needs a value for unique id types
            child: ExpensesItem(expenses[index])) );
  }
}
