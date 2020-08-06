class Item{
  int itemId;//id primary key
  int expenseId;//foreign key
  String itemName;
  String itemAmount;
  bool completed;

  Item({
    this.itemId,this.itemName,this.expenseId,
    this.itemAmount,this.completed
})   : assert(itemName != null, "Name can not be null");


  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      itemId: map['itemId'],
      expenseId: map['expenseId'],
      itemName: map['itemName'],
      itemAmount: map['itemAmount'],
      completed: map['completed'] == 0 ? false : true,


    );
  }
  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'expenseId': expenseId,
      'itemName': itemName ?? '',
      'itemAmount': itemAmount,
      'completed': completed==false?0:1
    };
  }


}