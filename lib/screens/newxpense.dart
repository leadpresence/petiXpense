import 'package:flutter/material.dart';
import 'Expenses.dart';

class NewXpensePage extends StatefulWidget {
  State<StatefulWidget> createState() => _NewXpensePage();
}

class _NewXpensePage extends State {
  String name;
  double amount;
  TextEditingController xpensename = new TextEditingController();
  TextEditingController xpenseBudgetAmt = new TextEditingController();
  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('New Expense'),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: TextField(
                        controller: xpensename,
                        decoration: InputDecoration(
                            hintText: 'e.g 1.20 ',
                            labelText: 'Price',
                            labelStyle: TextStyle(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            )),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'Expense Amount',
                            hintText: 'eg. 10500',
                            errorText: validate
                                ? 'please enter amount for expense'
                                : null),
                        textCapitalization: TextCapitalization.words,
                        controller: xpenseBudgetAmt,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: RaisedButton(
                      color: Colors.limeAccent,
                      child: Text('Enter Items'),
                      elevation: 5.0,
                      splashColor: Colors.lime,
                      onPressed: () {
                        //here we set the name and amount of the expense to the user input
                        setState() {
                          xpensename.text.isEmpty
                              ? validate = true
                              : validate = false;
                          xpenseBudgetAmt.text.isEmpty
                              ? validate = true
                              : validate = false;
                          xpenseDetails();
                        }

//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(
////                            builder: (BuildContext context) => ExpenseItems(),
//                          ),
//                        );
                      }),
                )
              ],
            )
          ],
        ));
  }

  xpenseDetails() {
    name = xpensename.text;
    amount = double.parse(xpenseBudgetAmt.text);
  }
}
