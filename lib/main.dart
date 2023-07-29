import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/main_page.dart';

import 'provider/pr.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Pr>(
        create: (_) => Pr(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final double maxWidth = 600.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Цвет фона (серый) вокруг главного контейнера
      child: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          width: MediaQuery.of(context).size.width < maxWidth ? MediaQuery.of(context).size.width : maxWidth,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: MainPage(),
            scrollBehavior: MyCustomScrollBehavior(),
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
