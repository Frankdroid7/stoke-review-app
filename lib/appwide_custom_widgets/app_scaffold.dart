import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key? key, this.appBar, required this.child})
      : super(key: key);

  final Widget child;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: child,
        ),
      ),
    );
  }
}
