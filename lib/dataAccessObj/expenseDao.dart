import 'dart:async';
import 'package:petixpense/database/expenseDatabase.dart';
import 'package:petixpense/models/ExpenseModel.dart';

class ExpenseDao {
  final dbProvider = ExpenseDatabaseProvider.dbProvider;

  //Adds new Expense records
  Future<int> createExpense(Expense expense) async {
    final db = await dbProvider.database;
    var result = db.insert(expenseTABLE, expense.toMap());
    return result;
  }

  //Get All Expense items
  //Searches if query string was passed
  Future<List<Expense>> getExpenses({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(expenseTABLE,
            columns: columns,
            where: 'name LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(expenseTABLE, columns: columns);
    }

    List<Expense> expenses = result.isNotEmpty
        ? result.map((item) => Expense.fromMap(item)).toList()
        : [];
    return expenses;
  }

  //Update Expense record
  Future<int> updateExpense(Expense expense) async {
    final db = await dbProvider.database;
    var result = await db.update(expenseTABLE, expense.toMap(),
        where: "expenseId = ?", whereArgs: [expense.expenseId]);
    return result;
  }

  //Delete Expense records
  Future<int> deleteExpense(int expenseId) async {
    final db = await dbProvider.database;
    var result = await db.delete(expenseTABLE, where: 'expenseId = ?', whereArgs: [expenseId]);
    return result;
  }


  Future deleteAllExpenses() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      expenseTABLE,
    );
    return result;
  }


}