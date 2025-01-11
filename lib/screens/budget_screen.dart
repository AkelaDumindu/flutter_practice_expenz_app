import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/models/expenses_modal.dart';
import 'package:flutter_expenz_app/models/income_modals.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/utilz/constant.dart';
import 'package:flutter_expenz_app/widgets/category_card.dart';
import 'package:flutter_expenz_app/widgets/pie_chart.dart';

class BudgetPage extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotals;
  final Map<IncomeCategory, double> incomeCategoryTotals;
  const BudgetPage(
      {super.key,
      required this.expenseCategoryTotals,
      required this.incomeCategoryTotals});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int _selectedmethod = 0;

  //methode to find the category color from the category
  Color getCategoryColor(dynamic category) {
    if (category is ExpenseCategory) {
      return expenseCategoryColors[category]!;
    } else {
      return incomeCategoryColors[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedmethod == 0
        ? widget.expenseCategoryTotals
        : widget.incomeCategoryTotals;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Financial Report",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kBlack,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefalutPadding, vertical: kDefalutPadding / 2),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: kWhite,
                  boxShadow: [
                    BoxShadow(
                      color: kBlack.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedmethod = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: _selectedmethod == 1 ? kWhite : kRed,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 60,
                          ),
                          child: Text(
                            "Expense",
                            style: TextStyle(
                              color: _selectedmethod == 0 ? kWhite : kBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedmethod = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: _selectedmethod == 0 ? kWhite : kGreen,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 60,
                          ),
                          child: Text(
                            "Income",
                            style: TextStyle(
                              color: _selectedmethod == 1 ? kWhite : kBlack,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Charts(
                expenseCategoryTotal: widget.expenseCategoryTotals,
                incomeCategoryTotal: widget.incomeCategoryTotals,
                isExpense: _selectedmethod == 0),

            const SizedBox(height: 50),
            // List of categories

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final category = data.keys.toList()[index];
                  final total = data.values.toList()[index];
                  return CategoryCard(
                    title: category.name,
                    amount: total,
                    total: data.values.reduce((a, b) => a + b),
                    progressColor: getCategoryColor(category),
                    isExpense: _selectedmethod == 0,
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
