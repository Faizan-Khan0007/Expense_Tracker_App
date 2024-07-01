

import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses%20list/expenses_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';

import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  //we are creating a list of of the Same Expense class type
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'flutter',
        amount: 12.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'movies',
        amount: 120.99,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,//this makes it to the full screen
        context: context,
        builder: (ctx) =>  NewExpense(onAddExpense:_addExpense,));
  } // this is the function made for the plus button it will display that UI i.e
  //overlay which is done after pressing the '+' icon
  //here ctx is the context and it is an object full of metadata hence u
  //have all the info about position in the widget tree and more
  //showModal fn is provided by flutter

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }
  //We made this fn so that we can pass values in it and then add it to the
  //corresponding list

  void _removeExpense(Expense expense){
    final expenseIndex=_registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();//instantly clears the previous
                                                   // snackbar message if any
    //scaffold messenger op for undo
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: const Duration(seconds: 3),
            content: const Text('Expense Deleted'),
            action: SnackBarAction(
            label:'Undo',
            onPressed:(){
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
                //we are using insert inplace of add so that the expense removed should undo at
                //the same place
              });

            }
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    Widget mainContent= const Center(child:Text("No expenses found.Start Adding some"),);
    if(_registeredExpenses.isNotEmpty){
      mainContent=ExpensesList(
          expenses: _registeredExpenses,
          onRemoveExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'), // gives the title
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
        //The actions property is a list of widgets that are displayed at the right side of the AppBar.
      ),
      body:width<600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ):Row(
        children: [
          Expanded(child: Chart(expenses: _registeredExpenses)),
          //Whenever there is a problem of sizes in widget inside a widget
          // Expanded is the key
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
