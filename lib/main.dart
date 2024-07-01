
import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColorScheme=ColorScheme.fromSeed(
    seedColor: const  Color.fromARGB(255, 100, 59, 181));

var kDarkColorScheme=ColorScheme.fromSeed(
   brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  runApp(
     MaterialApp(
       //copyWith makes sure that we will use more default values for provided by the particular
       // class and also we can use properties then inside it like below
       darkTheme: ThemeData().copyWith(
         colorScheme: kDarkColorScheme,
         scaffoldBackgroundColor: kDarkColorScheme.background,
         cardTheme: const CardTheme().copyWith(
           color: kDarkColorScheme.secondaryContainer,
           margin: const EdgeInsets.symmetric(
             vertical: 8,
             horizontal: 16,
           ),
         ),
         elevatedButtonTheme: ElevatedButtonThemeData(
             style: ElevatedButton.styleFrom(
               backgroundColor: kDarkColorScheme.secondaryContainer,
             )
         ),
       ),
      theme: ThemeData().copyWith(
        colorScheme:kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        //Card theme setting
        cardTheme: const CardTheme().copyWith(
           color: kColorScheme.secondaryContainer,
           margin: const EdgeInsets.symmetric(
             vertical: 8,
             horizontal: 16,
           ),
        ),
        //Elevated theme setting
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.secondaryContainer,
          )
        ),
        //Text theme setting
        textTheme:ThemeData().textTheme.copyWith(
              titleLarge:const  TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    ),
  );
}