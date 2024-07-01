import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget{
  const ExpensesItem(this.expense,{super.key});

  final Expense expense;
  //here expense is having the first value of that expense type list
  //and yup by using . we can access its values

  @override
  Widget build(BuildContext context) {
    return Card(child:
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              children: [
                Text(
                  expense.title,
                  style:const  TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ) ,),
                const SizedBox(height: 4,),
                Row(
                  children: [
                    Text("\$${expense.amount.toStringAsFixed(2)}"),
                    // \$ for the real dollar sign
                    const Spacer(),
                    Row(
                      children: [
                         Icon(categoryIcons[expense.category]),
                        //here we are making the use of the categoryIcons so yup we are using
                        //it but note here we are passing category from expense file so yes
                        const SizedBox(width: 8,),
                        Text(expense.formattedDate),
                        // here note that we are using the getter function and the
                        // getter function is used without braces by . and so
                      ],
                    )
                  ],
                )
              ],
            )
          ),

      );
  }
}