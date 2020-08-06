import 'dart:async';
import 'package:petixpense/database/expenseDatabase.dart';
import 'package:petixpense/models/ItemModel.dart';

class ItemDao {
  final dbProvider = ExpenseDatabaseProvider.dbProvider;

  //Adds new Item records
  Future<int> createItem(Item item) async {
    final db = await dbProvider.database;
    var result = db.insert(itemTABLE, item.toMap());
    return result;
  }

  //Get All Item items
  //Searches if query string was passed
  Future<List<Item>> getExpenseItems({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(itemTABLE,
            columns: columns,
            where: 'expenseId == $query');
//            whereArgs: ["%$query%"]);
    } else {

      result = await db.query(itemTABLE, columns: columns);
    }

    List<Item> items = result.isNotEmpty
        ? result.map((item) => Item.fromMap(item)).toList()
        : [];
    return items;
  }

  //Update Item record
  Future<int> updateItem(Item item) async {
    final db = await dbProvider.database;
    var result = await db.update(expenseTABLE, item.toMap(),
        where: "itemId = ?", whereArgs: [item.expenseId]);
    return result;
  }


  //Items of same expenseId

//  Future<List<Item>> getExpenseItems({List<String> columns, String expenseId}) async {
//    final db = await dbProvider.database;
//
//    // Query the table for all The Dogs.
//    final List<Map<String, dynamic>> result = await db.query('itemTABLE',columns: columns
//    ,where: 'expenseId LIKE ?',whereArgs: ["$expenseId"]);
//
//    //Convert the list in to a Map
//    List<Item> items = result.isNotEmpty
//        ? result.map((item) => Item.fromMap(item)).toList()
//        : [];
//    return items;
//  }

  //Delete Item records
  Future<int> deleteItem(int itemId) async {
    final db = await dbProvider.database;
    var result = await db.delete(itemTABLE, where: 'itemId = ?', whereArgs: [itemId]);

    return result;
  }


  Future deleteAllItems() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      itemTABLE,
    );
    return result;
  }


}