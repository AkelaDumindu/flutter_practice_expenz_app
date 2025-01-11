import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/models/income_modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeServices {
  //expense list
  List<Income> incomeList = [];

  // Define the key for storing expenses in shared preferences
  static const String _incomeKey = 'expenses';

  //Save the expense to shared preferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      // Convert the existing expenses to a list of Expense objects(first convert previouse expenses to dart object)
      List<Income> existingExpenseObjects = [];
      if (existingIncomes != null) {
        existingExpenseObjects = existingIncomes
            .map((e) => Income.fromJson(json.decode(e)))
            .toList();
      }

      // Add the new expense to the list (now add new one to the dart expense object list)
      existingExpenseObjects.add(income);

      // Convert the list of Expense objects back to a list of strings(again convert to list of string to store shared preferences so only store string list)
      List<String> updatedIncomes =
          existingExpenseObjects.map((e) => json.encode(e.toJson())).toList();

      // Save the updated list of expenses to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncomes);

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  // ===================================

  //load the expenses from shared preferences
  Future<List<Income>> loadIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingincomes = prefs.getStringList(_incomeKey);

    // Convert the existing expenses to a list of Expense objects
    List<Income> loadedExpenses = [];
    if (existingincomes != null) {
      loadedExpenses =
          existingincomes.map((e) => Income.fromJson(json.decode(e))).toList();
    }

    // Return the list of loaded expenses
    return loadedExpenses;
  }

//-------------------------------------------------------------
  //Delete the income from shared preferences from the id
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      // Convert the existing expenses to a list of Income objects
      List<Income> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJson(json.decode(e)))
            .toList();
      }

      // Remove the income with the specified id from the list
      existingIncomeObjects.removeWhere((element) => element.id == id);

      // Convert the list of incomes objects back to a list of strings
      List<String> updatedIncomes =
          existingIncomeObjects.map((e) => json.encode(e.toJson())).toList();

      // Save the updated list of incomes to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncomes);

      //show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Income deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e.toString());

      //show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('error of deleted Income'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // Function to delete all incomes
  Future<void> deleteAllIncomes(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Clear all incomes from shared preferences
      await prefs.remove(_incomeKey);

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All incomes deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
