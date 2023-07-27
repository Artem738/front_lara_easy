import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../provider/pr.dart';
import '../models/book.dart';

class ScreenThree extends StatefulWidget {
  @override
  _ScreenThreeState createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Screen Three")),
    );
  }
}
