import 'package:petixpense/models/ItemModel.dart';
import 'package:petixpense/dataAccessObj/itemDao.dart';


class ItemRepository {
  final itemDao = ItemDao();
  //viewAll

  Future getAllItems({String query}) => itemDao.getExpenseItems(query:  query);

  //Add
  Future insertItem(Item item) => itemDao.createItem(item);

  //Edit
  Future updateItem(Item item) => itemDao.updateItem(item);

  //delete
  Future deleteItemById(int id) => itemDao.deleteItem(id);

//deleteAll
  Future deleteAllItems() => itemDao.deleteAllItems();
}