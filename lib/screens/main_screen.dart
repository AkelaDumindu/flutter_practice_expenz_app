import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/models/expenses_modal.dart';
import 'package:flutter_expenz_app/models/income_modals.dart';
import 'package:flutter_expenz_app/screens/add_item_screen.dart';
import 'package:flutter_expenz_app/screens/budget_screen.dart';
import 'package:flutter_expenz_app/screens/homepage_screen.dart';
import 'package:flutter_expenz_app/screens/profile_screen.dart';
import 'package:flutter_expenz_app/screens/transaction_screen.dart';
import 'package:flutter_expenz_app/services/expense_services.dart';
import 'package:flutter_expenz_app/services/income_services.dart';
import 'package:flutter_expenz_app/utilz/color.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  //current page index
  // int _currentPageIndex = 0;
  List<Expenses> expenseList = [];
  List<Income> incomeList = [];

  //fetch expenses
  void fetchAllExpenses() async {
    List<Expenses> loadedExpenses = await ExpenseServices().loadExpenses();
    // Update expensesList with the fetched expenses
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //fetch incomes
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeServices().loadIncome();
    // Update expensesList with the fetched expenses
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  // Function to add a new expense
  void addNewExpense(Expenses newExpense) {
    // Save the new expense to shared preferences
    ExpenseServices().saveExpense(newExpense, context);

    // Update the list of expenses
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // Function to add a new income
  void addNewIncome(Income newIncome) {
    // Save the new expense to shared preferences
    IncomeServices().saveIncome(newIncome, context);

    // Update the list of expenses
    setState(() {
      incomeList.add(newIncome);
    });
  }

  // Function to delete an expense
  void deleteExpense(Expenses expense) {
    // Delete the expense from shared preferences
    ExpenseServices().deleteExpense(expense.id, context);

    // Update the list of expenses
    setState(() {
      expenseList.remove(expense);
    });
  }

  // Function to delete an income
  void deleteIncome(Income income) {
    // Delete the expense from shared preferences
    IncomeServices().deleteIncome(income.id, context);

    // Update the list of expenses
    setState(() {
      incomeList.remove(income);
    });
  }

  //category total expenses
  Map<ExpenseCategory, double> calculateExpensesCategories() {
    Map<ExpenseCategory, double> categoryTotals = {
      ExpenseCategory.food: 0,
      ExpenseCategory.transport: 0,
      ExpenseCategory.shopping: 0,
      ExpenseCategory.health: 0,
      ExpenseCategory.subscription: 0,
    };

    for (Expenses expense in expenseList) {
      categoryTotals[expense.category] =
          categoryTotals[expense.category]! + expense.amount;
    }

    //print the food category total
    // print(categoryTotals[ExpenseCategory.health].runtimeType);

    return categoryTotals;
  }

  //category total income
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotals = {
      IncomeCategory.salary: 0,
      IncomeCategory.freelance: 0,
      IncomeCategory.passive: 0,
      IncomeCategory.sales: 0,
    };

    for (Income income in incomeList) {
      categoryTotals[income.category] =
          categoryTotals[income.category]! + income.amount;
    }

    //print the food category total
    // print(categoryTotals[IncomeCategory.salary].runtimeType);

    return categoryTotals;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePage(
        expensesList: expenseList,
        incomeList: incomeList,
      ),
      TransactionPage(
        expensesList: expenseList,
        dismissesExpenses: deleteExpense,
        incomeList: incomeList,
        dismessedIncomes: deleteIncome,
      ),
      AddItem(
        addExpense: addNewExpense,
        addIncome: addNewIncome,
      ),
      BudgetPage(
        incomeCategoryTotals: calculateIncomeCategories(),
        expenseCategoryTotals: calculateExpensesCategories(),
      ),
      const ProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: kMainColor, shape: BoxShape.circle),
              child: const Icon(
                Icons.add,
                size: 30,
                color: kWhite,
              ),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: "Budget",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          )
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
