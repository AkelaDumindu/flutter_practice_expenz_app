import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/models/expenses_modal.dart';
import 'package:flutter_expenz_app/models/income_modals.dart';
import 'package:flutter_expenz_app/services/expense_services.dart';
import 'package:flutter_expenz_app/services/income_services.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/utilz/constant.dart';
import 'package:flutter_expenz_app/widgets/custom_button.dart';
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {
  final Function(Expenses) addExpense;
  final Function(Income) addIncome;

  const AddItem({super.key, required this.addExpense, required this.addIncome});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  int _selectedMethod = 0;
  ExpenseCategory _expenseCategory = ExpenseCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethod == 0 ? kRed : kGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefalutPadding),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                //expenz and income container
                Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: kWhite,
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 0;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: _selectedMethod == 0 ? kRed : kWhite),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10),
                              child: Text(
                                "Expenses",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        _selectedMethod == 0 ? kWhite : kBlack),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 1;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _selectedMethod == 1 ? kGreen : kWhite,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 10),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        _selectedMethod == 1 ? kWhite : kBlack),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //amount section

                Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How much',
                          style: TextStyle(
                              color: kLightGrey.withOpacity(0.8),
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                        const TextField(
                          style: TextStyle(
                              fontSize: 60,
                              color: kWhite,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              hintText: '0',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: kWhite,
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ),

                //user data form in white background

                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    //add to the form
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          //add dropdown menu
                          DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ),
                              ),
                              value: _selectedMethod == 0
                                  ? _expenseCategory
                                  : _incomeCategory,
                              items: _selectedMethod == 0
                                  ? ExpenseCategory.values.map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList()
                                  : IncomeCategory.values.map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedMethod == 0
                                      ? _expenseCategory =
                                          value as ExpenseCategory
                                      : _incomeCategory =
                                          value as IncomeCategory;
                                });
                              }),

                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 20,
                          ),
                          //title field

                          TextFormField(
                            controller: _titleController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a title";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //description field

                          TextFormField(
                            controller: _descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a description";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //amount field

                          TextFormField(
                            controller: _amountController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter a title";
                              }

                              double? amount = double.tryParse(value);
                              if (amount == null || amount <= 0) {
                                return "Please Enter valid amount";
                              }

                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 20,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //add the date picker

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2025),
                                  ).then((onValue) {
                                    if (onValue != null) {
                                      setState(() {
                                        _selectedDate = onValue;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kMainColor),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month_rounded,
                                          color: kWhite,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select Date",
                                          style: TextStyle(color: kWhite),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selectedDate),
                                style: const TextStyle(
                                    color: kGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          //add time picker

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedTime = DateTime(
                                            _selectedDate.year,
                                            _selectedDate.month,
                                            _selectedDate.day,
                                            value.hour,
                                            value.minute);
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: kYellow),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.punch_clock_outlined,
                                          color: kWhite,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Select Time",
                                          style: TextStyle(color: kWhite),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(_selectedTime),
                                style: const TextStyle(
                                    color: kGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          const Divider(
                            color: kLightGrey,
                            thickness: 5,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          GestureDetector(
                            onTap: () async {
                              if (_selectedMethod == 0 &&
                                  _formKey.currentState!.validate()) {
                                // adding expenses
                                //save the expense or income in shared preferences
                                List<Expenses> loadedExpenses =
                                    await ExpenseServices().loadExpenses();

                                //create expense to store
                                Expenses expenses = Expenses(
                                  id: loadedExpenses.length + 1,
                                  title: _titleController.text,
                                  amount: _amountController.text.isEmpty
                                      ? 0
                                      : double.parse(_amountController.text),
                                  category: _expenseCategory,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  description: _descriptionController.text,
                                );

                                //add expense to the list
                                widget.addExpense(expenses);

                                //clear fields
                                _titleController.clear();
                                _descriptionController.clear();
                                _amountController.clear();
                              } else {
                                //adding income

                                // load Income
                                List<Income> loadedIncome =
                                    await IncomeServices().loadIncome();
                                // create income
                                Income income = Income(
                                    id: loadedIncome.length + 1,
                                    title: _titleController.text,
                                    amount: _amountController.text.isEmpty
                                        ? 0
                                        : double.parse(_amountController.text),
                                    category: _incomeCategory,
                                    date: _selectedDate,
                                    time: _selectedTime,
                                    description: _descriptionController.text);

                                widget.addIncome(income);

                                //clear fields
                                _titleController.clear();
                                _descriptionController.clear();
                                _amountController.clear();
                              }
                            },
                            child: CustomButton(
                                buttonName: "Add",
                                color: _selectedMethod == 0 ? kRed : kGreen),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
