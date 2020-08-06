import 'package:flutter/material.dart';
class SystemPadding extends StatelessWidget {
  final Widget child;

  SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
      //Collapse dialog on focus
        padding: mediaQuery.viewPadding,
        duration: const Duration(milliseconds: 200),
        child: child);
  }
}