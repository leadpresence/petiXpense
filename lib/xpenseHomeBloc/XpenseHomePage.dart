import 'package:flutter/material.dart';
//import 'package:petixpense/screens/xpenseHomeBloc/xpense_home_bloc.dart';
//import 'package:petixpense/screens/xpenseHomeBloc/xpense_home_event.dart';
import 'package:petixpense/imports.dart';



class XpenseHomePage extends StatefulWidget {
  @override
  _XpenseHomePageState createState() => _XpenseHomePageState();
}

class _XpenseHomePageState extends State<XpenseHomePage> {
  String _expenseName;
  num _budgetAmount;
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  ExpenseBloc expenseBloc =ExpenseBloc();
  @override
  Widget build(_buildContext) {
    return
      Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'PetiXpense',
                  style: TextStyle(fontSize: 50, fontStyle: FontStyle.italic),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    color: Colors.limeAccent,
                    child: Text('New Expense'),
                    elevation: 5.0,
                    splashColor: Colors.lime,
                    onPressed: () {
//                        newExpenseDetails();
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (BuildContext context) {
                            return Container(
                                height: 205 * UIConstant.heightMultiplier,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 25 * UIConstant.heightMultiplier),
                                  child: Container(
                                    height: 120 * UIConstant.heightMultiplier,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0),
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0.5 *
                                                  UIConstant.heightMultiplier,
                                              horizontal: 2 *
                                                  UIConstant.widthMultiplier),
                                          //Top  Icons
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.only(
                                                  top: 16,
                                                  left: 16,
                                                ),
                                                child: GestureDetector(
                                                  child: Icon(
                                                    CupertinoIcons.clear,
                                                    color: Colors.black,
                                                    size: 10 *
                                                        UIConstant
                                                            .imageSizeMultiplier,
                                                  ),
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                              Spacer(),
                                              Text("Tag Expense"),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: UIConstant.widthMultiplier,
                                              bottom:
                                                  UIConstant.widthMultiplier,
                                              left:
                                                  UIConstant.widthMultiplier *
                                                      6,
                                              right:
                                                  UIConstant.widthMultiplier *
                                                      6),
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(top: 10.0),
                                            height:
                                                UIConstant.heightMultiplier *
                                                    7,
                                            child: Center(
                                              child: TextField(
                                                onChanged: (value){
                                                  setState(() {

                                                    name.text=value;
                                                  });
                                                },
                                                controller: name,
                                                decoration: InputDecoration(
                                                    hintText: 'e.g weekend ',
                                                    labelText: 'Expense Name',
                                                    labelStyle: TextStyle(),
                                                    border:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5.0),
                                                    )),
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: UIConstant.widthMultiplier,
                                              bottom:
                                                  UIConstant.widthMultiplier,
                                              left:
                                                  UIConstant.widthMultiplier *
                                                      6,
                                              right:
                                                  UIConstant.widthMultiplier *
                                                      6),
                                          child: Container(
                                            margin:
                                                EdgeInsets.only(top: 10.0),
                                            height:
                                                UIConstant.heightMultiplier *
                                                    7,
                                            child: Center(
                                              child: TextField(
                                                onChanged: (value){
                                                  setState(() {
                                                    amount.text=value;
                                                  });
                                                },
                                                controller: amount,
                                                decoration: InputDecoration(
                                                    hintText: '\₦120 ',
                                                    labelText: 'Amount',
                                                    labelStyle: TextStyle(),
                                                    border:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(5.0),
                                                    )),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 0.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: UIConstant
                                                        .widthMultiplier *
                                                    20,
//                                right:UIConstant.widthMultiplier*90,
                                              ),
                                              child: RaisedButton(
                                                  color: Colors.limeAccent,
                                                  child: Text('Done'),
                                                  elevation: 5.0,
                                                  splashColor: Colors.lime,
                                                  onPressed: () {
                                                    Navigator.pop(context);
//                                                    BlocProvider.of<ExpenseBloc>(context).add(
//                                                        ExpenseEvent.save(
//                                                             Expense(
//                                                                name: name.text,
//                                                                budgetAmount: amount.text,
//                                                                createdAt: DateTime.now(),
//                                                               category: "Uncategorized"
//                                                        )
//                                                    )
//                                                    );



                                                  final newExpense=  Expense(
                                                        name: name.text,
//                                                        budgetAmount: amount.text,
                                                        createdAt: DateTime.now(),
                                                        category: "Uncategorized"
                                                    );
                                                    if( newExpense.name.isNotEmpty){
                                                      expenseBloc.addExpense(newExpense);
                                                    }
                                                    debugPrint(amount.text);
                                                    debugPrint(name.text);
                                                  }),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: UIConstant
                                                        .widthMultiplier *
                                                    20,
//                              left:UIConstant.widthMultiplier*90,
                                              ),
                                              child: RaisedButton(
                                                  color: Colors.limeAccent,
                                                  child: Text('cancel'),
                                                  elevation: 5.0,
                                                  splashColor: Colors.lime,
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    //here we set the name and amount of the expense to the user input
                                                  }),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                          });
                    }),
              ],
            ),
            Container(padding: EdgeInsets.only(bottom: 15.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Colors.lime,
                  child: Text('View Expenses'),
                  elevation: 5.0,
                  splashColor: Colors.lime,
                  onPressed: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (BuildContext context) => ExpenseItems(),
//                      ),
//                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }




}
