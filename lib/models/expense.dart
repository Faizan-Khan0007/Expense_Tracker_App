// expenses list ka maal yaha pada hai


//import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';//intl provides us the date format ok...

final formatter = DateFormat.yMd();
// this is the function in which we are using the special constructor fn yMd which is
// year month and date

const uuid = Uuid(); // making the function to be stored in a variable

enum Category{food,leisure,work,travel}
//note that the enum feature values are not include in quotes
// and yup Category is now working as a variable having values something type like that

const categoryIcons = {
  Category.food:Icons.lunch_dining,
  Category.travel:Icons.flight_takeoff,
  Category.leisure:Icons.movie,
  Category.work:Icons.work,
};// here we make a constant value in a form of key value pairs i.e. map

class Expense {
  Expense({required this.title,
    required this.amount,
    required this.date,
    required this.category})
      : id = uuid.v4();
  //v4 method is there which is helpful
  //in generating new unique ids
  // also this colon is a one  way by which we can give values to the variable

  final String id; //id is not the required variable it is taken in the prog itself
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  //GETTER FUNCTION
  String get formattedDate{
    return formatter.format(date);
    //.format is a method from the date format class provided by intl package
  }// this is a getter fn
}

//this bucket class is there for the chart section how we will built it
class ExpenseBucket{
  ExpenseBucket({required this.category,required this.expenses});

  final Category category;
  final List<Expense>expenses;

  //we are adding a constructor function here so that we can filter the list
  //by using the where method which return a boolean value
  ExpenseBucket.forCategory(List<Expense>allExpenses,this.category)
      :expenses=allExpenses.where((expense) =>
             expense.category==category ).toList();

  //We are adding a getter fn so that we can calculate the sum of expenses of a
  // particular category
  double get totalExpenses{
    double sum=0;
    for(final expense in expenses){
      sum+=expense.amount;
    }
    return sum;
  }
}
