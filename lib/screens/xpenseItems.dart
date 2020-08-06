
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petixpense/imports.dart';
import 'package:petixpense/models/ItemModel.dart';
import 'package:petixpense/routes.dart';
import 'package:petixpense/screens/colors.dart';
import 'package:petixpense/widgets/dailogWidget.dart';
import 'package:petixpense/xpenseHomeBloc/item_bloc.dart';
import 'package:toast/toast.dart';

class ItemsView extends StatefulWidget {
  ItemsView(
      {Key key, this.title,
        @required this.expenseId,
        @required this.expenseName,
        @required this.expenseBudget,
        @required this.expenseBalance,
      }) : super(key: key);


  final String title;
  final int expenseId;
  final String expenseName;
  final double expenseBudget;
  final double expenseBalance;


  @override
  _ItemsViewState createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  final ItemBloc itemBloc = ItemBloc();
  int parentExpenseId;
  String parentExpenseName;

  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  void initState() {
    // TODO: implement initState
    print('--------------${widget.expenseBalance}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(

        appBar: AppBar(
          title: ListTile(
            leading: Text(widget.expenseName,style:UIConstant.titleItemAppBar),
//subtitle: Text('$widget.expenseBalance}',style:UIConstant.titleItemAppBar),
//            trailing: Text('Bal: {$widget.expenseBalance}',style:UIConstant.titleItemAppBar),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,

        ),
        resizeToAvoidBottomPadding: false,
        body: SafeArea(

            child: Container(
                color: Colors.white,
                padding:
                const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: Container(
                  //This is where the magic starts
                    child: getItemsWidget()))),
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
                      itemBloc.getItems();
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
                      CupertinoIcons.back,
                      size: 28,
                      color: Colors.lime,
                    ),
                    onPressed: () {
                      /*
                      * Back to parent  Expense Screen*/
                        Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 28,
                      color: Colors.lime,
                    ),
                    onPressed: () {
//                      _showExpenseSearchSheet(context);
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
//              _showAddExpenseSheet(context);
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



  Widget getItemsWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (Items)
    and construct the UI (with state) based on the stream
    */
    return FutureBuilder(
      future: itemBloc.getItems(query: widget.expenseId.toString()),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return getItemCardWidget(snapshot);
      },
    );
  }
  Widget getItemCardWidget(AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data.length != 0
          ? ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, itemPosition) {
          Item item = snapshot.data[itemPosition];
          final Widget dismissibleCard = new Dismissible(
            background: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Deleting",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              color: Colors.redAccent,
            ),
            onDismissed: (direction) {
    /*Delete Item when its dismissed*/
              itemBloc.deleteItemById(item.itemId);
            },
            direction: _dismissDirection,
            key: new ObjectKey(item),
            child: Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[200], width: 0.5),
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white,
                child: ListTile(
                  leading: InkWell(

                    onTap: () {
                      //Reverse the value
                      item.completed = !item.completed;
                      print(item.completed);

                      final thisItem=Item(
                        itemName: item.itemName,
                        itemAmount: item.itemAmount,
                        expenseId: item.expenseId,
                        completed: item.completed
                      );

                      itemBloc.updateItem(thisItem);
                    },
                    child: Container(
                      //decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: item.completed
                            ? Icon(
                          Icons.done,
                          size: 26.0,
                          color: Colors.indigoAccent,
                        )
                            : Icon(
                          Icons.check_box_outline_blank,
                          size: 26.0,
                          color: Colors.limeAccent,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    item.itemName,
                    style: TextStyle(
                        fontSize: 16.5,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.w500,
                        decoration: item.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  trailing:Text(
                    item.itemAmount,
                    style: TextStyle(
                        fontSize: 12.5,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.normal,
                        decoration: item.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ) ,
                )),
          );
          return dismissibleCard;
        },
      )


          : Container(
          child: Center(
            //this is used whenever there 0 Expense
            //in the data base
            child: noItemsMessageWidget(),
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

  /*Prompt to show when user want to add Item*/
  void _showAddItemDialog(BuildContext context) {
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
                        child: Text("Add new item to "+ parentExpenseName,
                          overflow: TextOverflow.ellipsis,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new TextField(
                              keyboardType: TextInputType.text,
                              textInputAction:TextInputAction.next,
                              controller: _itemNameFormController,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Item Name', hintText: 'Shopping'),
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
                              textInputAction:TextInputAction.done,
                              autofocus: true,
                              decoration: new InputDecoration(
                                  labelText: 'Item Amount',
                                  hintText: 'eg. 12220'),
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
                          expenseId:parentExpenseId ,
                          itemName: _itemNameFormController.value.text,
                          itemAmount: _itemAmountFormController.text.toString(),
                        );
                        if (newItem.itemName.isNotEmpty) {
                          //Validation for an empty item
                          itemBloc.addItem(newItem);

                        }
                        //Dismisses the  Dialog
                        Navigator.pop(context);
                        itemBloc.getItems(query: parentExpenseId.toString());
                      })
                ],
              ),
            ),
          );
        });
  }

  Widget loadingData() {
    //pull Expenses again
    itemBloc.getItems(query: parentExpenseId.toString());
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

  Widget noItemsMessageWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Text(
            "Urrhhmm Items Should \n show up here.Hit + to Add Items",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }


  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    itemBloc.dispose();
    super.dispose();
  }
}
