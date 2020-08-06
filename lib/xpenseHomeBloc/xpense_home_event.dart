import 'package:petixpense/models/ExpenseModel.dart';
/*
* This class handles all events that can occur to an expense
* The name constructor handles specifically these events
* */

enum EventType{
  save,
  edit,
  delete,
}
class ExpenseEvent{
  Expense expense;
  int expenseId;
  EventType eventType;

  /*Three named Constructors  save, edit and delete are used to handle all the
  events with the enums event types
  * */

//To handle Adding  of an expense

  ExpenseEvent.save(Expense expense){
    this.eventType=EventType.save;
    this.expense=expense;
  }

//To handle Edit of an expense

  ExpenseEvent.edit(int index){
    this.eventType=EventType.edit;
    this.expenseId=index;
  }

//To handle deletion of an expense
  ExpenseEvent.delete(int index){
    this.eventType=EventType.delete;
    this.expenseId=index;

  }


}