import 'package:petixpense/models/ExpenseModel.dart';
import 'package:petixpense/dataAccessObj/expenseDao.dart';


class ExpenseRepository {
  final expenseDao = ExpenseDao();
  //viewAll

  Future getAllExpenses({String query}) => expenseDao.getExpenses(query: query);

  //Add
  Future insertExpense(Expense expense) => expenseDao.createExpense(expense);

  //Edit
  Future updateExpense(Expense expense) => expenseDao.updateExpense(expense);

  //delete
  Future deleteExpenseById(int id) => expenseDao.deleteExpense(id);

//deleteAll
  Future deleteAllExpenses() => expenseDao.deleteAllExpenses();
}