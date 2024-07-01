// the use of this class will be to take the input from the user

import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  //here we are making a new property named as onAddExpense which is the same
  // _addExpense passed to the newExpense

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController =
      TextEditingController(); //it a class which helps in controlling
  final _amountController = TextEditingController();

  DateTime?
      _selectedDate; //here ? signifies that if there is nothing take it as null

  //again date picker is also a build in function which helps in date related issues
  void _presentDatePicker() async {
    final now = DateTime.now(), //helping variable for showDatePicker
        firstDate = DateTime(now.year - 1, now.month, now.day); //same as now
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  //dispose function
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  // we have to dispose it once we have completed the task

  Category _selectedCategory = Category.work;
  // setting the initial value of the variable to work
  //here category is an enum feature

  //this submit function is important for the invalid input
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //show error message
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text("Please make sure a valid title,amount,date and category was entered"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("Okay"))
                ],
            //action which allows user to close the dialog
              ));

      return;//so that after this the code will not execute
    }
    widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
    //
    Navigator.pop(context);//cancelling once expenses are saved
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace=MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(16,16,16,keyboardSpace+16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
                // Its type of weird that we use here decoration for the labelling
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          _amountController, //its a controller for the amount
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ', // it will give a dollar sign before the no i.e paisa
                        label: Text("Amount"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'No date selected'
                            : formatter.format(_selectedDate!)),
                        //note here ! is there so that dart will understand that it can't be null
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month)),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  //ddb button contains item
                  DropdownButton(
                      value: _selectedCategory, // its a property holding the current selected value
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                                value: category,//selection by the user
                                child: Text(category.name.toUpperCase())),
                            //ddmenuitem is the list of items that a user can select from
                          ).toList(),
                      // Items:In items we are using Category enum and converting it to the map
                      //and using it as a list and map also wants some parameters and returns a value
                      //so here category is passed and the dropdownMenuItem is returned which helps
                      //to show the different values to the user and also selection

                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                  //OnChanged fn is very important because it takes the same value as selected by the user
                  //and it is not null then we are updating the state and yup the selected value is shown
                  //on the screen
                  const SizedBox(width: 41,),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // this navigator cancels the whole screen overlay
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text("save your expense"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
