import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petixpense/imports.dart';
import 'package:petixpense/models/ItemModel.dart';
import 'package:petixpense/routes.dart';
import 'package:petixpense/screens/Settings.dart';
import 'package:petixpense/screens/colors.dart';
import 'package:petixpense/screens/xpenseItems.dart';
import 'package:petixpense/widgets/dailogWidget.dart';
import 'package:petixpense/xpenseHomeBloc/item_bloc.dart';
import 'package:toast/toast.dart';

class ExpenseItems extends StatefulWidget {
  ExpenseItems({Key key, this.title}) : super(key: key);

  //We load our Expense BLoC that is used to get
  //the stream of Expense for StreamBuilder
  final String title;

  @override
  _ExpenseItemsState createState() => _ExpenseItemsState();
}

class _ExpenseItemsState extends State<ExpenseItems> {
  final ExpenseBloc expenseBloc = ExpenseBloc();
  final ItemBloc itemBloc = ItemBloc();
  int parentExpenseId;
  String parentExpenseName;
  double itemsAmtSum = 0;
  double balance = 0.0;
  final DismissDirection _dismissDirection = DismissDirection.horizontal;
  ColorSelection _colorSelection = ColorSelection();
  String expenseColor = 'White';

  //ENTER CATEGORY
  Widget requestCategory() {
    PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {});
      },
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.add_alarm),
          onPressed: () {
            print('Hello world');
          },
        ),
        title: Text('Title'),
        subtitle: Column(
          children: <Widget>[
            Text('Sub title'),
          ],
        ),
        trailing: Icon(Icons.account_circle),
      ),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Value1',
          child: Text('Choose value 1'),
        ),
        const PopupMenuItem<String>(
          value: 'Value2',
          child: Text('Choose value 2'),
        ),
        const PopupMenuItem<String>(
          value: 'Value3',
          child: Text('Choose value 3'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(
                    //This is where the magic starts
                    child: getExpensesWidget()))),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Colors.grey, width: 0.3),
            )),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.lime,
                      size: 28,
                    ),
                    onPressed: () {
                      //just re-pull UI for testing purposes
                      expenseBloc.getExpenses();
                    }),
                Expanded(
                  child: Text(
                    "PetiExpense",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'RobotoMono',
                        fontStyle: FontStyle.normal,
                        fontSize: 15),
                  ),
                ),
                Wrap(children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 28,
                      color: Colors.lime,
                    ),
                    onPressed: () {
                      expenseBloc.deleteExpenseAll();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                  )
                ])
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: FloatingActionButton(
            elevation: 5.0,
            onPressed: () {
              _showAddExpenseSheet(context);
            },
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              size: 32,
              color: Colors.lime,
            ),
          ),
        ));
  }

  /*
    * Sheet to add new Expense Booklet */
  void _showAddExpenseSheet(BuildContext context) {
    final _expenseAmountFormController = TextEditingController();
    final _expenseNameFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 9.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      //Row for expense Name
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _expenseNameFormController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText:
                                      'Expenditure on.. Credit from.. Debt for..',
                                  hintStyle: TextStyle(fontSize: 11),
                                  labelText: ' Expense Name',
                                  labelStyle: TextStyle(
                                      color: Colors.lime,
                                      fontWeight: FontWeight.w500)),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Empty name!';
                                }
                                return value.contains('')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),

                          //Category popUp
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.lime,
                              radius: 18,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.account_balance_wallet,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {}),
                            ),
                          )
                        ],
                      ),

                      /*
                      * Amount field
                      * */
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _expenseAmountFormController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'Amount',
                                  hintStyle: TextStyle(fontSize: 11),
                                  labelText: ' Amount',
                                  labelStyle: TextStyle(
                                      color: Colors.lime,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w500)),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Empty amount!';
                                }
                                return value.contains('')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.lime,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  final newExpense = Expense(
                                      name:
                                          _expenseNameFormController.value.text,
                                      budgetAmount: double.parse(
                                          _expenseAmountFormController.text),
                                      createdAt:
                                          DateTime.now().toIso8601String(),
                                      color: expenseColor,
                                      balance: 0.0,
                                      numberOfItems: 0);
                                  if (newExpense.name.isNotEmpty) {
                                    //Validation for an empty expense
                                    expenseBloc.addExpense(newExpense);
                                    //Dismisses the bottom sheet
                                    Navigator.pop(context);
                                  }
                                  expenseBloc.getExpenses();
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 3.0,
                        children: <Widget>[
                          getChip(
                            "Orange",
                            Colors.white70,
                            Colors.orangeAccent,
                          ),
                          getChip(
                            "Green",
                            Colors.white70,
                            Colors.greenAccent,
                          ),
                          //White Chip
                          getChip(
                            "White",
                            Colors.black,
                            Colors.white30,
                          ),

                          getChip(
                            "Cyan",
                            Colors.white70,
                            Colors.cyan,
                          ),

                          getChip(
                            "Pink",
                            Colors.white70,
                            Colors.pinkAccent,
                          ),

                          getChip("Red", Colors.white70, Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  double getBalance({@required double budget, @required double itemAmt,}) {
    double bal;
    while (budget > itemAmt) {
      itemsAmtSum += itemAmt;
//      bal = budget - itemsAmtSum;
    }
    setState(() {
      balance = itemsAmtSum;
    });
    return balance;
  }

  /*
  * Sheet to search  Expenses*/
  void _showExpenseSearchSheet(BuildContext context) {
    final _expenseSearchNameFormController = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: new Container(
              color: Colors.transparent,
              child: new Container(
                height: 230,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15, top: 25.0, right: 15, bottom: 30),
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _expenseSearchNameFormController,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                              autofocus: true,
                              decoration: const InputDecoration(
                                hintText: 'Search for Expense...',
                                labelText: 'Search *',
                                labelStyle: TextStyle(
                                    color: Colors.lime,
                                    fontWeight: FontWeight.w500),
                              ),
                              validator: (String value) {
                                return value.contains('@')
                                    ? 'Do not use the @ char.'
                                    : null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5, top: 15),
                            child: CircleAvatar(
                              backgroundColor: Colors.lime,
                              radius: 18,
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  /*This will get all Expenses
                                  that contains similar string
                                  in the textform
                                  */
                                  expenseBloc.getExpenses(
                                      query: _expenseSearchNameFormController
                                          .value.text);
                                  //dismisses the bottomsheet
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

/*
* COLOR CHIP TEMPLATE*/
  Widget getChip(String name, Color brushColor, Color backColor) {
    return GestureDetector(
      child: Chip(
        backgroundColor: backColor,
        label: Text(name),
        deleteIcon: Icon(Icons.brush),
        deleteIconColor: brushColor,
        onDeleted: () {},
      ),
      onTap: () {
        Toast.show(name, context, duration: Toast.LENGTH_SHORT);
        setState(() {
          expenseColor = name;
        });
        debugPrint("Color----------$expenseColor");
      },
    );
  }

  Widget getExpensesWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (Expenses)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: expenseBloc.expenses,
      builder: (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
        return getExpenseCardWidget(snapshot);
      },
    );
  }

  Widget getExpenseCardWidget(AsyncSnapshot<List<Expense>> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, itemPosition) {
                Expense expense = snapshot.data[itemPosition];
                final Widget dismissibleCard = new Dismissible(
                  background: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Deleting ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    color: Colors.black,
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      // dismissed to the left
                      expenseBloc.deleteExpenseById(expense.expenseId);
                    }
                  },
                  direction: _dismissDirection,
                  key: UniqueKey(),
                  child: Card(
                    color: _colorSelection.setColor(expense.color),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
//                 leading: Icon(Icons.arrow_drop_down_circle),
                          title: Text(expense.name),
                          subtitle: Text(
                            "\nAmount  " + expense.budgetAmount.toString(),
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          trailing: Text(
                            expense.category.toString() +
                                "\n\nBal:" +
                                expense.balance.toString(),
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            FlatButton(
                              textColor: const Color(0xFF6200EE),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => new ItemsView(
                                              expenseId: expense.expenseId,
                                              expenseBalance: balance,
                                              expenseName: expense.name,
                                              expenseBudget:
                                                  expense.budgetAmount,
                                            )));
                              },
                              child: const Chip(
                                label: Text("View Items"),
                                backgroundColor: Color(0xFFECEFF1),
                              ),
                            ),
                            FlatButton(
                              textColor: const Color(0xFF6200EE),
                              child: const Chip(
                                label: Text("Add Item"),
                                backgroundColor: Color(0xFFECEFF1),
                              ),
                              onPressed: () {
                                // Perform some action
                                _showAddItemDialog(context, expense: expense);
                                //get the tapped item ID by its position
                                setParentExpenseId(
                                    expense.expenseId, expense.name);
                                debugPrint("Expense ID--->" +
                                    expense.expenseId.toString());
                              },
                            ),
                            SizedBox(
                              width: 35,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
                return dismissibleCard;
              },
            )
          : Container(
              child: Center(
              //this is used whenever there 0 Expense
              //in the data base
              child: noExpenseMessageWidget(),
            ));
    } else {
      return Center(
        /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
        child: loadingData(),
      );
    }
  }

  int setParentExpenseId(num _parentExpenseId, String _parentExpenseName) {
    debugPrint("Tapped Expense--->>$parentExpenseId");
    setState(() {
      parentExpenseId = _parentExpenseId;
      parentExpenseName = _parentExpenseName;
    });
    return parentExpenseId;
  }

  /*Prompt to show when user want to add Item*/
  void _showAddItemDialog(BuildContext context, {Expense expense}) {
    final _itemAmountFormController = TextEditingController();
    final _itemNameFormController = TextEditingController();
    showDialog(
        context: context,
        builder: (builder) {
          return Container(
            child: new SystemPadding(
              child: AlertDialog(
                contentPadding: const EdgeInsets.all(8.0),
                content: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Add new item to " + parentExpenseName,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextField(
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              controller: _itemNameFormController,
                              autofocus: true,
                              decoration: new InputDecoration(
                                labelText: 'Item Name',
                                hintText: '',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextField(
                              controller: _itemAmountFormController,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Item Amount',
                                  hintText: 'eg. \$12220'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  new FlatButton(
                      child: const Text('CANCEL'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  new FlatButton(
                      child: const Text('DONE'),
                      onPressed: () {
                        final newItem = Item(
                            expenseId: parentExpenseId,
                            itemName: _itemNameFormController.value.text,
                            itemAmount:
                                _itemAmountFormController.text.toString(),
                            completed: false);
                        if (newItem.itemName.isNotEmpty) {
                          //Validation for an empty item
                          itemBloc.addItem(newItem);
                        }
//                        getBalance(budget: expense.budgetAmount,itemAmt: double.parse( _itemAmountFormController.text));

                        // Todo update parent expense Balance
                        final updateExp = Expense(
                          expenseId: expense.expenseId,
                          description: '',
                          name: expense.name,
                          balance: balance,
                          budgetAmount: expense.budgetAmount,
                          createdAt: expense.createdAt,
                          numberOfItems: expense.numberOfItems + 1,
                          color: expense.color,
                          image: expense.image,
                          category: expense.category,
                          completed: expense.completed,
                          locked: expense.locked,
                        );
                        print(expense.toMap());
                        expenseBloc.updateExpense(updateExp);
                        expenseBloc.getExpenses();
                        //Dismisses the  Dialog
//                        itemBloc.getItems(query: parentExpenseId.toString());
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          );
        });
  }

  Widget loadingData() {
    //pull Expenses again
    expenseBloc.getExpenses();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget noExpenseMessageWidget() {
    return Container(
      child: Text(
        "+ Start adding Expense...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    expenseBloc.dispose();
    super.dispose();
  }
}
