import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/pr.dart';

class ScreenTwo extends StatefulWidget {
  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
   // print(context.watch<Pr>().httpError);
    return Scaffold(
      body: Center(child: Text(context.watch<Pr>().httpError)),
    );
  }
}
