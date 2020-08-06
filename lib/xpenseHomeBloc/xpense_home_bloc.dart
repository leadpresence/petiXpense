import 'dart:async';

import 'package:petixpense/imports.dart';
import 'package:petixpense/repository/expenseRepo.dart';

class ExpenseBloc {
  //Get instance of the Repository
  final _expenseRepository = ExpenseRepository();
  final _expenseController = StreamController<List<Expense>>.broadcast();

  get expenses => _expenseController.stream;

  ExpenseBloc() {
    getExpenses();
  }
  getExpenses({String query}) async {
    _expenseController.sink.add(await _expenseRepository.getAllExpenses(query: query));
  }

  addExpense(Expense expense) async {
    await _expenseRepository.insertExpense(expense);
    getExpenses();
  }

  updateExpense(Expense expense) async {
    await _expenseRepository.updateExpense(expense);
    getExpenses();
  }

  deleteExpenseById(int id) async {
    await _expenseRepository.deleteExpenseById(id);
    getExpenses();
  }
  deleteExpenseAll()async {
    await _expenseRepository.deleteAllExpenses();
    getExpenses();
  }

  dispose() {
    _expenseController.close();
  }
}