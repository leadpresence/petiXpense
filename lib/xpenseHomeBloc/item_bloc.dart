import 'dart:async';

import 'package:petixpense/models/ItemModel.dart';
import 'package:petixpense/repository/itemRepo.dart';

import '../imports.dart';

class ItemBloc {
  //Get instance of the Repository
  final _itemRepository = ItemRepository();
   final _itemController = StreamController<List<Item>>.broadcast();
  List<Item> item;

  get items => _itemController.stream;
//  get allItems => item;

  ItemBloc() {
//    getItems();
  }
  getItems({String query}) async {
     _itemController.sink.add(await _itemRepository.getAllItems(query: query));
//    item = await _itemRepository.getAllItems(query: query);
//  return item;

  }

  addItem(Item expense) async {
    await _itemRepository.insertItem(expense);
    getItems();
  }

  updateItem(Item expense) async {
    await _itemRepository.updateItem(expense);
    getItems();
  }

  deleteItemById(int id) async {
    await _itemRepository.deleteItemById(id);
    getItems();
  }
  deleteItemAll()async {
    await _itemRepository.deleteAllItems();
    getItems();
  }

  dispose() {
    _itemController.close();
  }
}