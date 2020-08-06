class Expense {
  String name;
  int expenseId;
  String description;
  double budgetAmount;
  double balance;
  int numberOfItems;
  var createdAt;
  var image;
  String category;
  String color;
  bool locked;
  bool completed;

  Expense(
      {this.expenseId,
      this.name,
      this.budgetAmount,
      this.category,
      this.color,
      this.balance,
      this.createdAt,
      this.numberOfItems,
      this.description,
      this.image,
      this.locked=false,
      this.completed=false,
      });
//      : assert(name != null, "Name can not be null"),
//        assert(createdAt != null, "date & time of creation can not be  null");

   factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
        expenseId: map['expenseId'],
        name: map['name'],
        budgetAmount: map['budgetAmount'],
        balance: map['balance'],
        numberOfItems: map['numberOfItems'],
        createdAt: map['createdAt'],
        color : map['color'],
        image: map['image'],
        category: map['category'],
        locked: map['locked']== 0 ? false : true,
        completed: map['completed'] == 0 ? false : true,
    );
  }
//To sqflite
    Map<String, dynamic> toMap() {
      return {
      'expenseId': expenseId,
      'name': name ,
      'budgetAmount': budgetAmount,
      'balance': balance,
      'numberOfItems': numberOfItems,
      'createdAt':createdAt ,
      'color':color??'' ,
      'image': image??'',
      'category': category??'Uncategorized',
      'locked': locked==false?0:1,
      'completed': completed==false?0:1
      };
    }
}
