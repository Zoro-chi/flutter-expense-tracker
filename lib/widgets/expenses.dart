import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Groceries',
      amount: 100.0,
      category: Category.food,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Transportation',
      amount: 50.0,
      category: Category.transportation,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Rent',
      amount: 500.0,
      category: Category.housing,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Medicine',
      amount: 30.0,
      category: Category.health,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Movie',
      amount: 20.0,
      category: Category.entertainment,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Books',
      amount: 10.0,
      category: Category.education,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Others',
      amount: 5.0,
      category: Category.other,
      date: DateTime.now(),
    ),
  ];

  void _addExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: addExpense),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void deleteExpense(Expense expense) {
    final expesnseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expesnseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(child: Text('No expenses added yet!'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onDeleteExpense: deleteExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addExpenseOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
