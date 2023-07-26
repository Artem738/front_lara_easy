import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pr.dart';

class ScreenOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.watch<Pr>().test.toString()),
    );
  }
}