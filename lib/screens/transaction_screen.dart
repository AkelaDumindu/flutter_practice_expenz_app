import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/models/expenses_modal.dart';
import 'package:flutter_expenz_app/models/income_modals.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/utilz/constant.dart';
import 'package:flutter_expenz_app/widgets/expense_card.dart';
import 'package:flutter_expenz_app/widgets/income_card.dart';

class TransactionPage extends StatefulWidget {
  final List<Expenses> expensesList;
  final List<Income> incomeList;
  final void Function(Expenses) dismissesExpenses;
  final void Function(Income) dismessedIncomes;

  const TransactionPage(
      {super.key,
      required this.expensesList,
      required this.dismissesExpenses,
      required this.incomeList,
      required this.dismessedIncomes});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefalutPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "See your financial report",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kMainColor,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  "Expenses",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                ),

                // Show all the expenses
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: SingleChildScrollView(
                    // Wrap with SingleChildScrollView to make the content scrollable
                    child: Column(
                      children: [
                        widget.incomeList.isEmpty
                            ? const Text(
                                "No expenses added yet, add some expenses to see here",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kGrey,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap:
                                    true, // Set shrinkWrap to true to allow the ListView to adapt to its content size
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.expensesList.length,
                                itemBuilder: (context, index) {
                                  final expense = widget.expensesList[index];

                                  //Dismissible use for remove expense
                                  return Dismissible(
                                    key: ValueKey(expense),
                                    direction: DismissDirection.startToEnd,
                                    onDismissed: (direction) {
                                      setState(() {
                                        widget.dismissesExpenses(expense);
                                      });
                                    },
                                    child: ExpenseCard(
                                      title: expense.title,
                                      date: expense.date,
                                      amount: expense.amount,
                                      category: expense.category,
                                      description: expense.description,
                                      time: DateTime.now(),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                const Text(
                  "Incomes",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: SingleChildScrollView(
                    // Wrap with SingleChildScrollView to make the content scrollable
                    child: Column(
                      children: [
                        widget.incomeList.isEmpty
                            ? const Text(
                                "No expenses added yet, add some expenses to see here",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kGrey,
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap:
                                    true, // Set shrinkWrap to true to allow the ListView to adapt to its content size
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.incomeList.length,
                                itemBuilder: (context, index) {
                                  final income = widget.incomeList[index];

                                  //Dismissible use for remove expense
                                  return Dismissible(
                                    key: ValueKey(income),
                                    direction: DismissDirection.startToEnd,
                                    onDismissed: (direction) {
                                      setState(() {
                                        widget.dismessedIncomes(income);
                                      });
                                    },
                                    child: IncomeCard(
                                      title: income.title,
                                      date: income.date,
                                      amount: income.amount,
                                      category: income.category,
                                      description: income.description,
                                      time: DateTime.now(),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
