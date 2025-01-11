import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/models/expenses_modal.dart';
import 'package:flutter_expenz_app/models/income_modals.dart';
import 'package:flutter_expenz_app/services/user_data_service.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/utilz/constant.dart';
import 'package:flutter_expenz_app/widgets/expense_card.dart';
import 'package:flutter_expenz_app/widgets/income_expence_card.dart';
import 'package:flutter_expenz_app/widgets/lline_chart.dart';

class HomePage extends StatefulWidget {
  final List<Expenses> expensesList;
  final List<Income> incomeList;
  const HomePage(
      {super.key, required this.expensesList, required this.incomeList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //for store user name
  String userName = "";
  double expenseTotal = 0;
  double incomeTotal = 0;

  @override
  void initState() {
    // get the user name from the shared preference
    UserService.getUserDetails().then(
      (value) {
        if (value["userName"] != null) {
          setState(() {
            userName = value["userName"]!;
          });
        }
      },
    );

    setState(() {
      for (var i = 0; i < widget.expensesList.length; i++) {
        expenseTotal += widget.expensesList[i].amount;
      }

      for (var i = 0; i < widget.incomeList.length; i++) {
        incomeTotal += widget.incomeList[i].amount;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

          // main column
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(kDefalutPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: kMainColor,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/user.jpg",
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Welcome $userName",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            color: kMainColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IncomeExpenceCard(
                            title: "Income",
                            amount: incomeTotal,
                            color: kGreen,
                            imageUrl: "assets/images/income.png"),
                        IncomeExpenceCard(
                            title: "Expense",
                            amount: expenseTotal,
                            color: kRed,
                            imageUrl: "assets/images/expense.png")
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //line chart about Spend Frequency
            const Padding(
              padding: EdgeInsets.all(kDefalutPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Spend Frequency",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  //chart to show the spend frequency and the amount spent in a chart using fl_chart

                  LineChartSample(),
                ],
              ),
            ),

            //recent transaction
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefalutPadding),
              child: Column(
                children: [
                  const Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //show the recent transactions

                  Column(
                    children: [
                      widget.expensesList.isEmpty
                          ? const Text(
                              "No expenses added yet, add some expenses to see here",
                              style: const TextStyle(
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
                                return ExpenseCard(
                                  title: expense.title,
                                  date: expense.date,
                                  amount: expense.amount,
                                  category: expense.category,
                                  description: expense.description,
                                  time: DateTime.now(),
                                );
                              },
                            ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
