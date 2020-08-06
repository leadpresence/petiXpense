import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'UIConstants.dart';
import 'Expenses.dart';

class StartXpense extends StatefulWidget {
  State<StatefulWidget> createState() => _StartXpense();
}

class _StartXpense extends State {
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
                  padding: EdgeInsets.only(
                      top: 5.0,
                    left: UIConstant.widthMultiplier*89

                  ),
                  child:GestureDetector(
                    child:Icon(
                      CupertinoIcons.add,
                      color: Colors.black,
                      size: 12 * UIConstant.imageSizeMultiplier,
                    ),
                    onTap: requestBottomSheet,
                  )
                ),
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
              ],
            )
          ],
        ));
  }

  void requestBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return Container(
              height: 205 * UIConstant.heightMultiplier,

              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.only(top: 25 * UIConstant.heightMultiplier),
                child: Container(
                  height: 120 * UIConstant.heightMultiplier,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5 * UIConstant.heightMultiplier,
                            horizontal: 4 * UIConstant.widthMultiplier),
                        //Top  Icons
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.clear,
                              color: Colors.black,
                              size: 10 * UIConstant.imageSizeMultiplier,
                            ),
                            Spacer(),
                            Text("Tag Expense"),
                            Spacer(),
                          ],
                        ),
                      ),

                      /*
                      Search Field
                      * */
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.lime.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child:
                            TextFormField(
//                              controller: search,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.lime,
                              style: GoogleFonts.nunitoSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 4.6 * UIConstant.textMultiplier),
                              decoration: InputDecoration.collapsed(
                                  hintText: "Tag",
                                  hintStyle: TextStyle(
                                      fontSize:
                                      1.7 * UIConstant.textMultiplier,
                                      color: Colors.grey)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 0.0,),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left:UIConstant.widthMultiplier*20,
//                                right:UIConstant.widthMultiplier*90,
                            ),
                            child: RaisedButton(
                                color: Colors.limeAccent,
                                child: Text('Done'),
                                elevation: 5.0,
                                splashColor: Colors.lime,
                                onPressed: () {
                                  //here we set the name and amount of the expense to the user input


                                }),

                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                              right:UIConstant.widthMultiplier*20,
//                              left:UIConstant.widthMultiplier*90,
                            ),
                            child: RaisedButton(
                                color: Colors.limeAccent,
                                child: Text('cancel'),
                                elevation: 5.0,
                                splashColor: Colors.lime,
                                onPressed: () {
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
  }


}
