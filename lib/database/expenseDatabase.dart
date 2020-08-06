import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


//Our Tables
final expenseTABLE = 'Expense';
final itemTABLE = 'Item';
//Database Provider
class ExpenseDatabaseProvider {
  static final ExpenseDatabaseProvider dbProvider =ExpenseDatabaseProvider();
  Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }
  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"Expense.db is our database instance name
    String path = join(documentsDirectory.path, "Expense.db");
    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }
  void initDB(Database database, int version) async {
    await database.execute('''CREATE TABLE $expenseTABLE (
        expenseId INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,
        description TEXT,
        category TEXT,color TEXT,
        image BLOB,budgetAmount REAL,
        balance REAL,numberOfItems INTEGER ,
        createdAt BLOB,
        completed INTEGER,
        locked INTEGER)'''
        );
    await database.execute('''CREATE TABLE $itemTABLE(
     itemId INTEGER PRIMARY KEY AUTOINCREMENT,
     expenseId INTEGER,
     itemName TEXT,
     itemAmount TEXT,        
     completed INTEGER,
     FOREIGN KEY (expenseId)    REFERENCES $expenseTABLE (expenseId))'''
    );
  }


}

