import 'dart:ui';

enum ExpenseCategory {
  shopping,
  subscription,
  food,
  health,
  transport,
}

final Map<ExpenseCategory, String> expensesCategoryImages = {
  ExpenseCategory.food: "assets/images/restaurant.png",
  ExpenseCategory.transport: "assets/images/car.png",
  ExpenseCategory.health: "assets/images/health.png",
  ExpenseCategory.shopping: "assets/images/bag.png",
  ExpenseCategory.subscription: "assets/images/bill.png",
};

final Map<ExpenseCategory, Color> expenseCategoryColors = {
  ExpenseCategory.food: const Color(0xFFE57373),
  ExpenseCategory.transport: const Color(0xFF81C784),
  ExpenseCategory.health: const Color(0xFF64B5F6),
  ExpenseCategory.shopping: const Color(0xFFFFD54F),
  ExpenseCategory.subscription: const Color(0xFF9575CD),
};

class Expenses {
  final int id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expenses(
      {required this.id,
      required this.title,
      required this.amount,
      required this.category,
      required this.date,
      required this.time,
      required this.description});

  // Convert the Expense object to a JSON object senierlization

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'description': description,
    };
  }

  //convert json object to expense object

  factory Expenses.fromJson(Map<String, dynamic> json) {
    return Expenses(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      category: ExpenseCategory.values[json['category']],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      description: json['description'],
    );
  }
}
