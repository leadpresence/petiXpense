import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petixpense/imports.dart';
import 'package:petixpense/screens/Settings.dart';
import 'package:petixpense/screens/welcome.dart';
import 'package:petixpense/screens/xpenseItems.dart';


const String ExpenseRoute = "Expense";
const String ItemsRoute = "Items";
const String WelcomeRoute = "/";
const String SettingsRoute = "Settings";




Route<dynamic> onGenerateRoute(RouteSettings settings) {
  Expense expense=Expense();
  switch (settings.name) {
    case ExpenseRoute:
      return
        MaterialPageRoute(
            settings: RouteSettings(
                name: settings.name
            ),
            builder: (BuildContext context)=>ExpenseItems()

        );
    case ItemsRoute:
      return
        MaterialPageRoute(
            settings: RouteSettings(
                name: settings.name
            ),
            builder: (BuildContext context)=>ItemsView()

        );
    case ItemsRoute:
      return
        MaterialPageRoute(
            settings: RouteSettings(
                name: settings.name
            ),
            builder: (BuildContext context)=>Welcome()

        );
    case ItemsRoute:
      return
        MaterialPageRoute(
            settings: RouteSettings(
                name: settings.name

            ),
            builder: (BuildContext context)=>Settings()

        );





  }
}