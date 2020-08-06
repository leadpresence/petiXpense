import 'package:flutter/material.dart';
import 'package:petixpense/imports.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petixpense/routes.dart';
import 'package:petixpense/screens/xpenseItems.dart';

void main() {
  runApp(PetiXpense());
  BlocSupervisor.delegate=ExpenseDelegate();
}

class PetiXpense extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        UIConstant().init(constraints, orientation);

        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'petixpense',
            color: Colors.lime,
            theme: ThemeData(
              primarySwatch: Colors.lime,
            ),
            onGenerateRoute: onGenerateRoute,
            initialRoute: WelcomeRoute,
            home: ExpenseItems());
      });
    });
  }
}
