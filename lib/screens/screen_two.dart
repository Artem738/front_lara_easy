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
    return Scaffold(
      body: Center(child: Text(context.watch<Pr>().books.length.toString())),
    );
  }
}
